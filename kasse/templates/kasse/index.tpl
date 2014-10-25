<!DOCTYPE html>
{% load staticfiles %}
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gruppenkasse</title>

    <!-- Bootstrap -->
    <link href="{% static "bootstrap/css/bootstrap.min.css" %}" rel="stylesheet">
    {% block sidebar_include %}<link href="{% static "bootstrap/css/simple-sidebar.css" %}" rel="stylesheet">{% endblock %}
    <link href="{% static "bootstrap/css/bootstrap-table.css" %}" rel="stylesheet">
    
    <link href="{% static "kasse/css/main.css" %}" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
     <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">

          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Zeige Navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" id="menu-toggle" href="{% url 'index' %}">
            <img src='{% static 'kasse/img/sidebar-icon.png' %}'/>
            Gruppenkasse
          </a>
          <!--<button type="button"  id="menu-toggle" class="btn btn-default  navbar-toggle">
            <span class="sr-only">Zeige Sidebar</span>
            <span class="icon-bar"></span>
          </button>-->
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            {% block veranstaltung_nav %}
                <li class='{% if location == "veranstaltungen" %} active {% endif %}'><a href="{% url 'veranstaltungen' %}">Veranstaltungen</a></li>
            {% endblock %}
            {% block personen_nav %}
                <li {% if location == "personen" %} class='active' {% endif %}><a href="{% url 'person' %}">Personen</a></li>
            {% endblock %}
            {% block buchungen_nav %}
                <li {% if location == "buchungen" %} class='active' {% endif %}><a href="{% url 'buchungen' %}">Buchungen</a></li>
            {% endblock %}
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>



    
    <div id="wrapper">

        {% block sidebar %}{% endblock %} 
        
        <!-- Page Content -->
        <div id="page-content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="{% block grid_class %}col-lg-12{% endblock %}">
                        {% block content %}{% endblock %}
                    </div>
                </div>
            </div>
        </div>
        <!-- /#page-content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="{% static "bootstrap/js/jquery-2.1.1.min.js" %}"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="{% static "bootstrap/js/bootstrap.min.js" %}"></script>
    <script src="{% static "bootstrap/js/bootstrap-table.min.js" %}"></script>
    
    <script src="{% static "kasse/js/main.js" %}"></script>
  </body>
</html>
