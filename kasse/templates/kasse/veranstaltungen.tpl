{% extends "kasse/index.tpl" %}

{% block content %}
    <h1>Liste der Veranstaltungen</h1>
    <div class="list-group">
        {% for veranstaltung in veranstaltungen %}
            <a href="#" class="list-group-item">
                <span class="badge">14</span>
                {{veranstaltung.datum}}: {{veranstaltung}}
            </a>
        {% endfor %}
    </div>
{% endblock %}


