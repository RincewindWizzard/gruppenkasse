from django.conf.urls import patterns, url
from kasse import views

urlpatterns = patterns('',
    url(r'^$', views.index, name='index'),
    url(r'^buchungen/$', views.buchungen, name='buchungen'),
    url(r'^personen/$', views.person, {'person_slug': None}, name='person'),
    url(r'^personen/(.*)$', views.person, name='person'),
    url(r'^veranstaltungen/$', views.veranstaltungen, name='veranstaltungen'),
)
