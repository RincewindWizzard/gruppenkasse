{% extends "kasse/index.tpl" %}

{% block sidebar %}
<ul class="nav nav-sidebar ">
    {% for person in personen %}
        <li><a href="{% url 'person' person|slugify %}">{{ person }}</a></li>
    {% endfor %}
</ul>
{% endblock %}

{% block content %}
    {% if person == None %}
        Bite w&auml;hlen Sie eine Person in der Sidebar. {{ slug }}
    {% else %}
            <h1 id="{{ person|slugify }}">{{ person }}</h1>
            
            {% if person.saldo < 0 %}
                <div class="alert alert-danger compact" role="alert">
                    <div class="panel-body">
                        Es fehlen noch {{ person.saldo }} &euro;.
                    </div>
                </div>
            {% elif person.saldo > 0 %}
                <div class="alert alert-success compact" role="alert">
                    <div class="panel-body">
                        {{ person.vorname }} erh&auml;lt noch {{ person.saldo }} &euro;.
                    </div>
                </div>
            {% endif %}
            <p>
            {{ person.vorname }} hat an
            {% for veranstaltung in person.teilnahmen.all %} 
                <a href="{% url 'veranstaltungen' %}#{{ veranstaltung|slugify }}">{{ veranstaltung }}</a>{% if not forloop.last %}{% if forloop.revcounter0 > 1 %}, {% else %} und {% endif %}{% endif %}
            {% endfor %}
            teilgenommen, insgesamt {{ person.eingezahlt}} &euro; eingezahlt und ist mit {{ person.forderungen }} &euro; an Veranstaltungen beteiligt.
            </p>
            
            {% if person.buchungen|length == 0 %}
                {{ person.vorname }} hat bis jetzt noch keine Buchungen vorgenommen.
            {% else %}
            <table class="table">
                <thead>
                    <tr>
                      <th>Datum</th>
                      <th>Verwendungszweck</th>
                      <th class="text-right">Betrag</th>
                    </tr>
                </thead>
                <tbody>
                {% for buchung in person.buchungen %}
                    <tr class="{% if buchung.betrag >= 0 %} success {% else %} danger {% endif %}">
                        <td>{{ buchung.datum }}</td>
                        <td><a href="{% url 'veranstaltungen' %}#{{ buchung.verwendungszweck|slugify }}"> {{ buchung.verwendungszweck }}</a></td>
                        <td class="text-right">
                            {% if buchung.betrag >= 0 %}+{% endif %}{{ buchung.betrag }} &euro;
                        </td>
                    </tr>
                {% endfor %}
            </table>
            {% endif %}
        
    {% endif %}
{% endblock %}
