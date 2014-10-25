# -*- coding: utf-8 -*-
from django.shortcuts import render, render_to_response, redirect, get_object_or_404
from django.contrib.auth import authenticate, login
from django.db.models import Sum
from django.template import RequestContext
from django.views.generic import ListView, DetailView
from django.contrib.auth.decorators import login_required, permission_required
from django.utils.decorators import method_decorator
from django.http import HttpResponse
from django.utils.html import escape
import json
from kasse.models import Veranstaltung, Person, Buchung, Veranstaltungsposition

from django.core import serializers

def index(request):
    context = {
        'veranstaltungen': Veranstaltung.objects.all().order_by('datum'),
        'personen': Person.objects.all(),
        'location': "index",
    }
    return render(request, 'kasse/dashboard.tpl', context)


class BuchungenList(ListView):
    model = Buchung
    context_object_name = 'buchungen'
    template_name = 'kasse/buchungen.tpl'
    
    def get_context_data(self, **kwargs):
        context = super(BuchungenList, self).get_context_data(**kwargs)
        context['buchungen_saldo'] = float(Buchung.objects.all().aggregate(Sum('betrag'))['betrag__sum'])
        context['veranstaltungen_kosten'] = float(Veranstaltungsposition.objects.all().aggregate(Sum('betrag'))['betrag__sum'])
        context['saldo'] = float(context['buchungen_saldo'] - context['veranstaltungen_kosten'])
        context['location'] = "buchungen"
        return context
        
    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(BuchungenList, self).dispatch(*args, **kwargs)        
         
class VeranstaltungView(DetailView):
    model = Veranstaltung
    context_object_name = 'veranstaltung'
    template_name = 'kasse/veranstaltungen.tpl'
    
    def get_context_data(self, **kwargs):
        context = super(VeranstaltungView, self).get_context_data(**kwargs)
        context['veranstaltungen'] = Veranstaltung.objects.all().order_by('datum')
        context['personen'] = Person.objects.all()
               
        teilnehmer_table = []
        for p in context['personen']:
            row = [unicode(p)]
            for pos in context['veranstaltung'].positionen():
                row.append(unicode(pos.verwendungszweck) in p.positionen(context['veranstaltung']))

            # Bezahlt?
            row.append(p.saldo() >= 0)
            teilnehmer_table.append(row)
                
        context['teilnehmer_table'] = teilnehmer_table
        
        context['location'] = "veranstaltungen"
        return context
        
    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(VeranstaltungView, self).dispatch(*args, **kwargs)
    

@login_required
def person(request, person_slug):
    if person_slug == None:
        person = Person.objects.all().first()
        if person:
            return redirect('person', person.slug)

    current_person = None
    try:
        current_person = Person.objects.get(slug=person_slug)
    except: # could not find person
        pass
            
    context = {
        'personen': Person.objects.all(),
        'slug' : person_slug,
        'person' : current_person,
        'location': "personen",
    }

    return render(request, 'kasse/personen.tpl', context)
    
@login_required    
def teilnehmer_json(request, veranstaltung_slug):
    veranstaltung = get_object_or_404(Veranstaltung, slug=veranstaltung_slug)
    
    json_dict = []
    for teilnehmer in veranstaltung.teilnehmer():
        row = {'name': unicode(teilnehmer)}
        for position in teilnehmer.veranstaltungspositionen(veranstaltung):
            print unicode(position.verwendungszweck)
            row[escape(unicode(position.verwendungszweck))] = True
        json_dict.append(row)
            
    return HttpResponse(unicode(json.dumps(json_dict, ensure_ascii=False)), content_type="application/json; charset=utf-8")
    
# loggt einen Besucher als Gast account ein
def gast_login(request, token):
    user = authenticate(username="gast", password=token)
    if user is not None:
        if user.is_active:
            login(request, user)
    return redirect('buchungen')

