{% extends "kasse/index.tpl" %}

{% block content %}
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
        <tr>
            <td>{{ buchung.person }}</td>
            <td>{{ buchung.datum }}</td>
            <td>{{ buchung.verwendungszweck }}</td>
            <td class="text-right {% if buchung.betrag >= 0 %} einzahlung {% else %} auszahlung {% endif %}">
                {% if buchung.betrag >= 0 %}+{% endif %}{{ buchung.betrag }} &euro;
            </td>
        </tr>
    {% endfor %}
</table>
{% endblock %}


  
