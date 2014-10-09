{% extends "kasse/index.tpl" %}

{% block sidebar %}
<ul class="nav nav-sidebar ">
    {% for person in personen %}
        <li><a href="#{{ person|slugify }}">{{ person }}</a></li>
    {% endfor %}
</ul>
{% endblock %}

{% block content %}
    {% for person in personen %}
        {% with vorname=person.vorname veranstaltungen=person.veranstaltungen forderungen=person.forderungen eingezahlt=person.eingezahlt saldo=person.saldo%}
            <h1 id="{{ person|slugify }}">{{ person }}</h1>
            
            {% if saldo < 0 %}
                <div class="alert alert-danger compact" role="alert">
                    <div class="panel-body">
                        Es fehlen noch {{ saldo }} &euro;.
                    </div>
                </div>
            {% elif saldo > 0 %}
                <div class="alert alert-success compact" role="alert">
                    <div class="panel-body">
                        {{ vorname }} erh&auml;lt noch {{ saldo }} &euro;.
                    </div>
                </div>
            {% endif %}
            <p>
            {{ vorname }} hat an
            {% for veranstaltung in veranstaltungen %} 
                <a href="{% url 'veranstaltungen' %}#{{ veranstaltung|slugify }}">{{ veranstaltung }}</a>{% if not forloop.last %}{% if forloop.revcounter0 > 1 %}, {% else %} und {% endif %}{% endif %}
            {% endfor %}
            teilgenommen.
            </p>
            
            <p>
                 {{ vorname }} hat insgesamt {{ eingezahlt}} &euro; eingezahlt und ist mit {{ forderungen }} &euro; an Veranstaltungen beteiligt.
            </p>
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
        
        {% endwith %}
    {% endfor %}
{% endblock %}
