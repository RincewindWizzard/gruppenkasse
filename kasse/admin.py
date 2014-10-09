from django.contrib import admin
from kasse.models import Veranstaltung, Person, Buchung, Veranstaltungsposition



class BuchungenAdmin(admin.ModelAdmin):
    list_display = ('verwendungszweck', 'datum', 'betrag')

    
class VeranstaltungspositionInline(admin.TabularInline):
    list_display = ('veranstaltung', 'verwendungszweck', 'betrag')
    model        = Veranstaltungsposition
    extra = 1

class VeranstaltungAdmin(admin.ModelAdmin):
    list_display = ('name', 'datum')
    exclude = ('slug',)
    inlines      = [VeranstaltungspositionInline]
    
class PersonAdmin(admin.ModelAdmin):
    #prepopulated_fields = {"slug": ("vorname",)}
    exclude = ('slug',)
    fieldsets = [
        (None,               {'fields': ['vorname', 'nachname']}),
        ('Veranstaltungen', {'fields': ['teilnahmen'], 'classes': ['collapse']}),
    ]

admin.site.register(Veranstaltung, VeranstaltungAdmin)
admin.site.register(Person, PersonAdmin)
admin.site.register(Buchung, BuchungenAdmin)


# Register your models here.
