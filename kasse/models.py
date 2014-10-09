from django.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.template.defaultfilters import slugify


@python_2_unicode_compatible
class Veranstaltung(models.Model):
    name = models.CharField(max_length=30)
    datum = models.DateField()
    slug  = models.SlugField()
    
    def kosten(self):
        kosten_sum = 0
        for position in Veranstaltungsposition.objects.filter(veranstaltung=self):
            kosten_sum += position.betrag
        return kosten_sum
        
    def kosten_pro_person(self):
        return float(self.kosten()) / self.person_set.count()
    
    def positionen(self):
        return self.veranstaltungsposition_set.all()
    
    
    def save(self, *args, **kwargs):
        self.slug = slugify(self.name)
        super(Veranstaltung, self).save(*args, **kwargs)
    
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
        for buchung in self.buchung_set.all():
                ret += buchung.betrag
        return ret
        
    def forderungen(self):
        ret = 0
        for veranstaltung in self.teilnahmen.all():
            ret += veranstaltung.kosten_pro_person()
        return ret
                
    def saldo(self):
        return round(float(self.eingezahlt()) - self.forderungen(),2)

    def buchungen(self):
        return Buchung.objects.filter(person=self)       
    
    def save(self, *args, **kwargs):
        self.slug = slugify(self.vorname + " " + self.nachname)
        super(Person, self).save(*args, **kwargs)
        
    def __str__(self):
        return self.vorname + " " + self.nachname


class Buchung(models.Model):
    person           = models.ForeignKey(Person, null=True, blank=True, default = None)
    datum            = models.DateField()
    verwendungszweck = models.CharField(max_length=100)
    betrag           = models.DecimalField(max_digits=6, decimal_places=2)

@python_2_unicode_compatible 
class Veranstaltungsposition(models.Model):
    veranstaltung    = models.ForeignKey(Veranstaltung)
    verwendungszweck = models.CharField(max_length=100)
    betrag           = models.DecimalField(max_digits=6, decimal_places=2)
    
    def __str__(self):
        return self.verwendungszweck
    

