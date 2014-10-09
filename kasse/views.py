from django.shortcuts import render, render_to_response, redirect
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

def person(request, person_slug):
    if person_slug == None:
        return redirect('person', Person.objects.all().first().slug)
    else:
        current_person = None
        try:
            current_person = Person.objects.get(slug=person_slug)
        except: # could not find person
            pass
            
        context = {
            'veranstaltungen': Veranstaltung.objects.all().order_by('datum'),
            'personen': Person.objects.all(),
            'slug' : person_slug,
            'person' : current_person,
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
    
    
