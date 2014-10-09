{% extends "kasse/index.tpl" %}

{% block personen_nav %}
    <li class='dropdown {% if location == "personen" %} active {% endif %}'>
        <a class="dropdown-toggle" data-toggle="dropdown" >Personen <span class="caret"></span></a>
        <ul class="dropdown-menu" role="menu">
            <li><a href="{% url 'personen' %}">Alle Personen</a></li>
            <li class="divider"></li>
                {% for person in personen %}
                    <li><a href="{% url 'personen' %}#{{ person }}">{{ person }}</a></li>
                {% endfor %}
        </ul>
    </li>
{% endblock %}

{% block content %}
    <h1>Liste der Personen</h1>
    <div class="list-group">
        {% for person in personen %}
            <a href="#" class="list-group-item">
                <span class="badge">14</span>
                {{person}}
            </a>
        {% endfor %}
    </div>
{% endblock %}
