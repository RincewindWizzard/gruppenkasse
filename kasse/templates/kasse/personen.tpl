{% extends "kasse/index.tpl" %}

{% block sidebar %}
<ul class="nav nav-sidebar">
    {% for person in personen %}
        <li><a href="#{{ person|slugify }}">{{ person }}</a></li>
    {% endfor %}
</ul>
{% endblock %}

{% block content %}
    {% for person in personen %}
        <h1 id="{{ person|slugify }}">{{ person }}</h1></a>
        {{ person.vorname }} hat an
        {% for veranstaltung in person.veranstaltungen %} 
            <a href="{% url 'veranstaltungen' %}#{{ veranstaltung|slugify }}">{{ veranstaltung }}</a>{% if not forloop.last %}{% if forloop.revcounter0 > 1 %}, {% else %} und {% endif %}{% endif %}
        {% endfor %}
        teilgenommen.
    {% endfor %}
{% endblock %}
