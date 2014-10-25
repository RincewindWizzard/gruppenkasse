from django.conf.urls import patterns, url
from kasse import views

urlpatterns = patterns('',
    url(r'^$', views.index, name='index'),
    url(r'^buchungen/$', views.BuchungenList.as_view(), name='buchungen'),
    url(r'^personen/$', views.person, {'person_slug': None}, name='person'),
    url(r'^personen/(.*)$', views.person, name='person'),
    url(r'^veranstaltungen/$', views.VeranstaltungView.as_view(), {'pk': 1}, name='veranstaltungen'),
    url(r'^veranstaltungen/(?P<slug>.*)$', views.VeranstaltungView.as_view(), name='veranstaltungen'),
    url(r'^json/teilnehmer/(.*)$', views.teilnehmer_json, name='teilnehmer_json'),
)
