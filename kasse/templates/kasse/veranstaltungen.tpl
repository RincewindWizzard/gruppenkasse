{% extends "kasse/index.tpl" %}

{% block sidebar %}
     <!-- Sidebar -->
    <div id="sidebar-wrapper" class="navbar navbar-default">
        <ul class="nav nav-sidebar ">
            {% for v in veranstaltungen %}
                <li class="{% ifequal veranstaltung v %}active{% endifequal %}"><a href="{% url 'veranstaltungen' v.slug %}" class="navbar-link">{{ v }}</a></li>
            {% endfor %}
            <li class="nav-divider"></li>
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
        
        {% if veranstaltung.person_set.all|length == 0 %}
            <p>Es gibt bis jetzt noch keine Teilnehmer f&uuml;r diese Veranstaltung.</p>
        {% else %}
            <h1>Teilnehmer</h1>
            
            <div class="list-group">
                {% for teilnehmer in veranstaltung.person_set.all %}
                    <a href="{% url 'person' teilnehmer|slugify %}" class="list-group-item {% if teilnehmer.saldo >= 0 %} list-group-item-success {% else %} list-group-item-danger {% endif %}">
                        {{ teilnehmer }}
                        {% if teilnehmer.saldo < 0 %}
                            <span class="badge">{{ teilnehmer.saldo }} &euro; fehlen</span>
                        {% endif %}

                    </a>
                {% endfor %}
            </div>
            <button type="button" class="btn btn-success pull-right">Hinzuf&uuml;gen</button>
        {% endif %}
    {% endif %}
   
{% endblock %}


