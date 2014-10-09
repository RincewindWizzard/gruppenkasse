from django.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.template.defaultfilters import slugify

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
    slug       = models.SlugField()
    teilnahmen = models.ManyToManyField(Veranstaltung, blank=True)
    
    def eingezahlt(self):
        ret = 0
        for buchung in Buchung.objects.filter(person=self):
                ret += buchung.betrag
        return ret
        
    def forderungen(self):
        return 0 #TODO: implement
                
    def saldo(self):
        return self.eingezahlt() - self.forderungen()

    def buchungen(self)       :
        return Buchung.objects.filter(person=self)       
    
    def save(self, *args, **kwargs):
        self.slug = slugify(self.vorname + " " + self.nachname)
        super(Person, self).save(*args, **kwargs)
        
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
    

