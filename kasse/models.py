from django.db import models
from django.utils.encoding import python_2_unicode_compatible


@python_2_unicode_compatible
class Veranstaltung(models.Model):
    name = models.CharField(max_length=30)
    datum = models.DateField()
    def __str__(self):
        return self.name

@python_2_unicode_compatible
class Person(models.Model):
    vorname    = models.CharField(max_length=30)
    nachname   = models.CharField(max_length=30)
    teilnahmen = models.ManyToManyField(Veranstaltung, blank=True)
    
    def __str__(self):
        return self.vorname + " " + self.nachname


class Buchung(models.Model):
    person           = models.ForeignKey(Person)
    datum            = models.DateField()
    verwendungszweck = models.ForeignKey(Veranstaltung)
    betrag           = models.DecimalField(max_digits=6, decimal_places=2)

@python_2_unicode_compatible 
class Veranstaltungsposition(models.Model):
    veranstaltung    = models.ForeignKey(Veranstaltung)
    verwendungszweck = models.CharField(max_length=100)
    betrag           = models.DecimalField(max_digits=6, decimal_places=2)
    
    def __str__(self):
        return self.verwendungszweck
    

