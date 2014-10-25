from django.conf.urls import patterns, include, url
from django.views.generic.base import RedirectView
from django.contrib import admin
admin.autodiscover()


urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'Gruppenkasse.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    url(r'^$', RedirectView.as_view(url='kasse/', permanent=False), name='index'),
    url(r'^kasse/', include('kasse.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^accounts/', include(admin.site.urls)),
)
