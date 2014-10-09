from django.shortcuts import render, HttpResponse, render_to_response
from django.template import RequestContext
from kasse.models import Veranstaltung, Person, Buchung, Veranstaltungsposition

def index(request):
    context = {
        'veranstaltungen': Veranstaltung.objects.all().order_by('datum'),
        'personen': Person.objects.all(),
        'location': "personen",
    }
    return render(request, 'kasse/dashboard.tpl', context)
    
def buchungen(request):  
    context = {
        'veranstaltungen': Veranstaltung.objects.all().order_by('datum'),
        'buchungen': Buchung.objects.all().order_by('datum'),
        'personen': Person.objects.all(),
        'location': "buchungen",
    }
    return render(request, 'kasse/buchungen.tpl', context)

def personen(request):
    context = {
        'veranstaltungen': Veranstaltung.objects.all().order_by('datum'),
        'personen': Person.objects.all(),
        'location': "personen",
    }
    # wichtige informationen fuer eine person hinzufuegen
    for person in context['personen']:
        person.veranstaltungen = person.teilnahmen.all()
        person.eingezahlt = 0
        person.forderungen = 0    #TODO: implement
       
        for buchung in Buchung.objects.filter(person=person):
            person.eingezahlt += buchung.betrag
            
        person.saldo = person.eingezahlt - person.forderungen
        
        person.buchungen = Buchung.objects.filter(person=person)
        
    return render(request, 'kasse/personen.tpl', context)
    
    
def veranstaltungen(request):
    context = {
        'veranstaltungen': Veranstaltung.objects.all().order_by('datum'),
        'personen': Person.objects.all(),
        'location':        "veranstaltungen",
    }
    return render(request, 'kasse/veranstaltungen.tpl', context)
    
    
