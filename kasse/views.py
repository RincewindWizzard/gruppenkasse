from django.shortcuts import render, render_to_response, redirect
from django.template import RequestContext
from kasse.models import Veranstaltung, Person, Buchung, Veranstaltungsposition

def index(request):
    context = {
        'veranstaltungen': Veranstaltung.objects.all().order_by('datum'),
        'personen': Person.objects.all(),
        'location': "index",
    }
    return render(request, 'kasse/dashboard.tpl', context)
    

    
def buchungen(request):
    saldo = 0
    for buchung in Buchung.objects.all():
        saldo += buchung.betrag
        
    context = {
        'buchungen': Buchung.objects.all().order_by('datum'),
        'saldo': saldo,
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
    
    
