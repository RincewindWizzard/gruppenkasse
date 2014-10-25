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
   
    def teilnehmer(self):
        teiln = []
        for position in self.veranstaltungsposition_set.all():
            for person in position.person_set.all():
                if not person in teiln:
                    teiln.append(person)
        return teiln
    
    def positionen(self):
        return self.veranstaltungsposition_set.all()
    
    
    def save(self, *args, **kwargs):
        self.slug = slugify(self.name)
        super(Veranstaltung, self).save(*args, **kwargs)
    
    def __str__(self):
        return self.name

@python_2_unicode_compatible 
class Veranstaltungsposition(models.Model):
    veranstaltung    = models.ForeignKey(Veranstaltung)
    verwendungszweck = models.CharField(max_length=100)
    betrag           = models.DecimalField(max_digits=6, decimal_places=2)
    
    def kosten_pro_person(self):
        return float(self.betrag) / self.person_set.count()
    
    def __str__(self):
        return str(self.veranstaltung) + " > " + self.verwendungszweck
    


@python_2_unicode_compatible
class Person(models.Model):
    vorname    = models.CharField(max_length=30)
    nachname   = models.CharField(max_length=30)
    slug       = models.SlugField()
    teilnahmen = models.ManyToManyField(Veranstaltungsposition, blank=True)
    
    def veranstaltungen(self, veranstaltung=None):
        veranstaltungen = []
        for position in self.teilnahmen.all():
            if not position.veranstaltung in veranstaltungen:
                veranstaltungen.append(position.veranstaltung)
        return veranstaltungen
    
    def positionen(self, veranstaltung=None):
        pos = []
        
        for position in self.teilnahmen.all() if veranstaltung == None else self.teilnahmen.filter(veranstaltung=veranstaltung):
            pos.append(unicode(position.verwendungszweck))
        return pos
    
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


