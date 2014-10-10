{% extends "kasse/index.tpl" %}

{% block sidebar %}
    <!-- Sidebar -->
    <div id="sidebar-wrapper" class="navbar navbar-default">
        <ul class="nav nav-sidebar ">
            {% for p in personen %}
                <li class="{% ifequal person p %}active{% endifequal %}"><a href="{% url 'person' p|slugify %}" class="navbar-link">{{ p }}</a></li>
            {% endfor %}
            <li>
                <div class="input-group">
                  <input type="text" class="form-control">
                  <span class="input-group-btn">
                    <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-plus"></span></button>
                  </span>
                </div><!-- /input-group -->
            </li>
        </ul>
    </div>
{% endblock %}

{% block content %}
    {% if not person %}
        Es gibt leider noch keine Personen.
    {% else %}
            <h1 id="{{ person|slugify }}">{{ person }}</h1>
            
            {% if person.saldo < 0 %}
                <div class="alert alert-danger compact" role="alert">
                    <div class="panel-body">
                        Es fehlen noch {{ person.saldo|floatformat:2 }} &euro;.
                    </div>
                </div>
            {% elif person.saldo > 0 %}
                <div class="alert alert-success compact" role="alert">
                    <div class="panel-body">
                        {{ person.vorname }} erh&auml;lt noch {{ person.saldo|floatformat:2 }} &euro;.
                    </div>
                </div>
            {% endif %}
            <p>
            {{ person.vorname }} hat an
            {% with veranstaltungen=person.teilnahmen.all %}
                {% if veranstaltungen|length == 0 %}
                    keiner Veranstaltung
                {% else %}
                    {% for veranstaltung in veranstaltungen %} 
                        <a href="{% url 'veranstaltungen' veranstaltung|slugify %}">{{ veranstaltung }}</a>
                        {% if not forloop.last %}{% if forloop.revcounter0 > 1 %}, {% else %} und {% endif %}{% endif %}
                    {% endfor %}
                {% endif %}
            {% endwith %}
            teilgenommen{% if person.eingezahlt != 0 %}, insgesamt {{ person.eingezahlt|floatformat:2 }} &euro; eingezahlt{% endif %}{% if person.forderungen == 0 %}.
            {% else %} und ist mit Kosten von {{ person.forderungen|floatformat:2 }} &euro; an Veranstaltungen beteiligt. {% endif %}
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
                        <td>{{ buchung.verwendungszweck }}</td>
                        <td class="text-right">
                            {% if buchung.betrag >= 0 %}+{% endif %}{{ buchung.betrag|floatformat:2 }} &euro;
                        </td>
                    </tr>
                {% endfor %}
            </table>
            {% endif %}
        
    {% endif %}
{% endblock %}
