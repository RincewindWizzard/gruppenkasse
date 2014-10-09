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
    return render(request, 'kasse/personen.tpl', context)
    
    
def veranstaltungen(request):
    context = {
        'veranstaltungen': Veranstaltung.objects.all().order_by('datum'),
        'personen': Person.objects.all(),
        'location':        "veranstaltungen",
    }
    return render(request, 'kasse/veranstaltungen.tpl', context)
    
    
