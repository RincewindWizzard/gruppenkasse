{% extends "kasse/index.tpl" %}

{% block content %}
    {% if buchungen|length == 0 %}
        Es gibt leider noch keine Buchungen.
    {% else %}
        <h1>Ein- und Auszahlungen in die Gruppenkasse</h1>
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
                    <td><a href="{% url 'person' buchung.person|slugify %}">{{ buchung.person }}</a></td>
                    <td>{{ buchung.datum }}</td>
                    <td><a href="{% url 'veranstaltungen' %}#{{ buchung.verwendungszweck|slugify }}" > {{ buchung.verwendungszweck }}</a></td>
                    <td class="text-right">
                        {% if buchung.betrag >= 0 %}+{% endif %}{{ buchung.betrag }} &euro;
                    </td>
                </tr>
            {% endfor %}
        </table>
    {% endif %}
{% endblock %}


  
