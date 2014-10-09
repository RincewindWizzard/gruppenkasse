{% extends "kasse/index.tpl" %}

{% block sidebar %}
<ul class="nav nav-sidebar ">
    {% for v in veranstaltungen %}
        <li class="{% ifequal veranstaltung v %}active{% endifequal %}"><a href="{% url 'veranstaltungen' v.slug %}" class="navbar-link">{{ v }}</a></li>
    {% endfor %}
</ul>
{% endblock %}

{% block content %}
    {% if not veranstaltung %}
        Es gibt leider noch keine Veranstaltungen.
    {% else %}
        <p>
        Die {{ veranstaltung }} hat {{ veranstaltung.kosten }} &euro; gekostet. 
        Davon fallen 
        {% for position in veranstaltung.positionen %}
            {{ position.betrag }} &euro; auf {{ position }}{% if not forloop.last %}{% if forloop.revcounter0 > 1 %}, {% else %} und {% endif %}{% else %}.{% endif %}
        {% endfor %}
        </p>
        <p>Fogende Personen nehmen teil:</p>
        
        <div class="list-group">
            {% for teilnehmer in veranstaltung.person_set.all %}
                <a href="{% url 'person' teilnehmer|slugify %}" class="list-group-item {% if teilnehmer.saldo >= 0 %} list-group-item-success {% else %} list-group-item-danger {% endif %}">
                    {{ teilnehmer }}
                    {% if teilnehmer.saldo < 0 %}
                        <span class="badge">Es fehlen noch {{ teilnehmer.saldo }} &euro;</span>
                    {% endif %}

                </a>
            {% endfor %}
        </div>
    {% endif %}
   
{% endblock %}


