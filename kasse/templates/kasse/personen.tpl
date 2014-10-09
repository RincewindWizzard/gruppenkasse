{% extends "kasse/index.tpl" %}


{% block content %}
    <h1>Liste der Personen</h1>
    <div class="list-group">
        {% for person in personen %}
            <a href="#{{ person|slugify }}" class="list-group-item">
                {{person}}
            </a>
        {% endfor %}
    </div>
    
    {% for person in personen %}
        <h1 id="{{ person|slugify }}">{{ person }}</h1></a>
    {% endfor %}
{% endblock %}
