{% extends "kasse/index.tpl" %}

{% block sidebar %}
     <!-- Sidebar -->
    <div id="sidebar-wrapper" class="navbar navbar-default">
        <ul class="nav nav-sidebar ">
            {% for v in veranstaltungen %}
                <li class="{% ifequal veranstaltung v %}active{% endifequal %}"><a href="{% url 'veranstaltungen' v.slug %}" class="navbar-link">{{ v }}</a></li>
            {% endfor %}
           
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
            {{ position.betrag }} &euro; auf {{ position.verwendungszweck }}{% if not forloop.last %}{% if forloop.revcounter0 > 1 %}, {% else %} und {% endif %}{% else %}.{% endif %}
        {% endfor %}
        </p>
        
        {% if veranstaltung.teilnehmer|length == 0 %}
            <p>Es gibt bis jetzt noch keine Teilnehmer f&uuml;r diese Veranstaltung.</p>
        {% else %}
            <h1>Teilnehmer</h1>
            
             <table class="table">
                <thead>
                    <tr>
                        <th>Person</th>
                        {% for position in veranstaltung.positionen %}
                            <th>{{ position.verwendungszweck }}</th>
                        {% endfor %}
                    </tr>
                </thead>
                <tbody>
                    {% for row in teilnehmer_table %}
                        <tr class="{% if row|last %} success {% else %} danger {% endif %}">
                            <td><a href="{% url 'person' row|first|slugify %}">{{ row|first }}</a></td>
                            {% for col in row|slice:"1:-1" %}
                                <td><form><input class='readonly' type="checkbox"  {% if col %}checked{% endif %}></form></td>
                            {% endfor %}
                        </tr>
                    {% endfor %}
                </tbody>
            </table>
        {% endif %}
    {% endif %}
   
{% endblock %}


