{% extends "kasse/index.tpl" %}

{% comment %}Sidebar entfernen{% endcomment %}
{% block sidebar_include %}{% endblock %}
{% block grid_class %}col-md-offset-1 col-lg-10{% endblock %}

{% block content %}
    {% if buchungen|length == 0 %}
        Es gibt leider noch keine Buchungen.
    {% else %}
        <h1>Ein- und Auszahlungen in die Gruppenkasse</h1>
        
        <div class="panel panel-default">
            <!-- Default panel contents -->
            <div class="panel-body">
                <p>Es befinden sich {{ saldo|floatformat:2 }} &euro; in der Gruppenkasse.</p>
            </div>
            
            <table class="table">
                <thead>
                    <tr>
                      <th>Person</th>
                      <th>Datum</th>
                      <th>Verwendungszweck</th>
                      <th class="text-right">Betrag</th>
                    </tr>
                </thead>
                <tbody>
                {% for buchung in buchungen %}
                    <tr class="{% if buchung.betrag >= 0 %} success {% else %} danger {% endif %}">
                        <td>{% if buchung.person %}<a href="{% url 'person' buchung.person|slugify %}">{{ buchung.person }}</a>{% else %}Spende{% endif %}</td>
                        <td>{{ buchung.datum }}</td>
                        <td>{{ buchung.verwendungszweck }}</td>
                        <td class="text-right">
                            {% if buchung.betrag >= 0 %}+{% endif %}{{ buchung.betrag|floatformat:2 }} &euro;
                        </td>
                    </tr>
                {% endfor %}
            </table>
        </div>
    {% endif %}
{% endblock %}


  
