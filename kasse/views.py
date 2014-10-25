# -*- coding: utf-8 -*-
from django.shortcuts import render, render_to_response, redirect, get_object_or_404
from django.template import RequestContext
from django.http import HttpResponse
from django.utils.html import escape
import json
from kasse.models import Veranstaltung, Person, Buchung, Veranstaltungsposition

def index(request):
    context = {
        'veranstaltungen': Veranstaltung.objects.all().order_by('datum'),
        'personen': Person.objects.all(),
        'location': "index",
    }
    return render(request, 'kasse/dashboard.tpl', context)
    

    
def buchungen(request):
    buchungen_saldo = 0
    veranstaltungen_kosten = 0

    for buchung in Buchung.objects.all():
        buchungen_saldo += buchung.betrag
        
    for veranstaltung in Veranstaltung.objects.all():
        veranstaltungen_kosten += veranstaltung.kosten()        
        
    context = {
        'buchungen': Buchung.objects.all().order_by('datum'),
        'buchungen_saldo': buchungen_saldo,
        'veranstaltungen_kosten': veranstaltungen_kosten,
        'saldo' : buchungen_saldo - veranstaltungen_kosten,
        'location': "buchungen",
    }
    return render(request, 'kasse/buchungen.tpl', context)

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
    
    
def veranstaltungen(request, veranstaltung_slug):
    if veranstaltung_slug == None:
        veranstaltung = Veranstaltung.objects.all().first()
        if veranstaltung:
            return redirect('veranstaltungen', veranstaltung.slug)

    veranstaltung = None
    try:
        veranstaltung = Veranstaltung.objects.get(slug=veranstaltung_slug)
    except:
        pass
        
    context = {
        'veranstaltungen': Veranstaltung.objects.all().order_by('datum'),
        'personen': Person.objects.all(),
        'veranstaltung' : veranstaltung,
        'location':        "veranstaltungen",
    }
    return render(request, 'kasse/veranstaltungen.tpl', context)
    
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
