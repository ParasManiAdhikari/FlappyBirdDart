## A bare-bones web app

Benutzen Sie dieses Projekt als Ausgangspunkt für Ihre eigenen Projekte.
Es ist so konfiguriert, dass Sie einfache

- Dart 2 Projekte

mit einer einfachen Build-Pipeline auf GitLab-Pages deployen können.

### Erste Schritte

In den folgenden Schritten lernen Sie:

- Wie Sie ein neues GitLab Projekt anlegen.
- Wie Sie die WebIDE von GitLab für einfache Änderungen nutzen können.
- Wie Sie mit CSS Regeln HTML-Dokumente gestalten können.
- Wie Sie mit Dart HTML-Dokumente manipulieren können.
- Wie Sie GitLab CI dazu nutzen können, ein Projekt automatisiert zu bauen und auf GitLab Pages zu deployen.

Am Ende sollten Sie ein Schachbrett gestaltet und aufgebaut haben.
Das ist sicher noch sehr weit von dem zu entwickelnden Spiel entfernt,
aber diese Basis-Kenntnisse sollen Ihnen helfen schnell Ihren persönlichen Einstieg in Ihr Spielprojekt zu finden.

### Legen Sie ein neues Projekt an

1. Loggen Sie sich in GitLab ein (dieselben Access credentials wie Moodle).
2. Navigieren Sie in einem Browser zu: https://git.mylab.th-luebeck.de/webtech/barebones
4. Klicken Sie auf __Fork__
5. Wählen Sie Ihren Namen als Namespace

Es sollte nun unter ihrem Account ein neues Projekt namens "barebones" angelegt worden sein
(falls nicht, wenden Sie sich an einen Betreuer).

### Starten Sie die WebIDE und legen Sie die Struktur eines Schachbretts mit Hilfe von HTML an

1. Navigieren Sie zu __Repository__ -> __Files__
2. Klicken Sie auf __WebIDE__
3. Öffnen Sie die Datei: __web/index.html__
4. Ersetzen Sie `<div id="output"></div>` durch
    ```HTML
    <table id="chess">
        <tr><td></td><td>A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td></tr>
        <tr><td>1</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        <tr><td>2</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        <tr><td>3</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        <tr><td>4</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        <tr><td>5</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        <tr><td>6</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        <tr><td>7</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        <tr><td>8</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
    </table>
    ```
5. Klicken Sie auf __Commit__ und dann auf __Stage & Commit__
6. Warten Sie bis die Build-Pipeline Ihre Seite gebaut hat und diese auf GitLab Pages deployt wurde.
7. Öffnen Sie dann mit einem Browser: <pre>http://[vorname.nachname].pages.mylab.th-luebeck.de/barebones/</pre>
8. Sie sollten nun eine unstyled Tabelle (Schachbrett) sehen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

### Gestalten Sie das Schachbrett mit Hilfe von CSS

1. Öffnen Sie in der __WebIDE__ die Datei: __web/style.css__
2. Ergänzen Sie die folgenden CSS Regeln
    ```CSS
    #chess {
        border-collapse: collapse;
        margin-left: auto;
        margin-right: auto;
    }

    #chess td {
        font-size: 40px;
        width: 60px;
        height: 60px;
        color: black;
        background: lightgrey;
        text-align: center;
        font-weight: bold;
    }

    #chess tr:nth-child(odd) td:nth-child(odd),
    #chess tr:nth-child(even) td:nth-child(even) {
        background: darkgray;
    }

    #chess tr:first-child td, #chess tr td:first-child {
        background: white !important;
        text-align: center;
        font-size: 20px;
    }
    ```
3. Klicken Sie auf __Commit__ und dann auf __Stage & Commit__
4. Warten Sie bis die Build-Pipeline Ihre Seite gebaut hat und diese auf GitLab Pages deployt wurde.
5. Öffnen Sie dann mit einem Browser: <pre>http://[vorname.nachname].pages.mylab.th-luebeck.de/barebones/</pre>
6. Sie sollten nun ein gut erkennbares Schachbrett erkennen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

___Tipp:__ Probieren Sie erst den Browser Firefox aus, sollten Sie keine Änderungen sehen. Browser wie Chrome, Safari, Edge,
etc. cachen aus Performancegründen häufig recht "optimistisch" - insbesondere Änderungen an CSS und JS (Dart) Dateien werden
nicht immer vom Webserver nachgeladen (da sich diese selten ändern!)._

### Platzieren Sie Schachfiguren auf dem Schachbrett (im DOM-Tree) mit Hilfe von Dart

1. Öffnen Sie in der __WebIDE__ die Datei: __web/main.dart__
2. Ergänzen Sie in der `main()`-Methode folgende Codezeilen.
    ```Dart
    // White
    querySelectorAll('#chess tr:nth-child(3) td:nth-child(n+2)').forEach((td) { td.innerHtml = "&#9817;"; });
    querySelectorAll('#chess tr:nth-child(2) td:nth-child(2), #chess tr:nth-child(2) td:nth-child(9)').forEach((td) { td.innerHtml = "&#9814;"; });
    querySelectorAll('#chess tr:nth-child(2) td:nth-child(3), #chess tr:nth-child(2) td:nth-child(8)').forEach((td) { td.innerHtml = "&#9816;"; });
    querySelectorAll('#chess tr:nth-child(2) td:nth-child(4), #chess tr:nth-child(2) td:nth-child(7)').forEach((td) { td.innerHtml = "&#9815;"; });
    querySelector('#chess tr:nth-child(2) td:nth-child(6)').innerHtml = "&#9812;";
    querySelector('#chess tr:nth-child(2) td:nth-child(5)').innerHtml = "&#9813;";

    // Black
    querySelectorAll('#chess tr:nth-child(8) td:nth-child(n+2)').forEach((td) { td.innerHtml = "&#9823;"; });
    querySelectorAll('#chess tr:nth-child(9) td:nth-child(2), #chess tr:nth-child(9) td:nth-child(9)').forEach((td) { td.innerHtml = "&#9820;"; });
    querySelectorAll('#chess tr:nth-child(9) td:nth-child(3), #chess tr:nth-child(9) td:nth-child(8)').forEach((td) { td.innerHtml = "&#9822;"; });
    querySelectorAll('#chess tr:nth-child(9) td:nth-child(4), #chess tr:nth-child(9) td:nth-child(7)').forEach((td) { td.innerHtml = "&#9821;"; });
    querySelector('#chess tr:nth-child(9) td:nth-child(5)').innerHtml = "&#9819;";
    querySelector('#chess tr:nth-child(9) td:nth-child(6)').innerHtml = "&#9818;";
    ```
3. Klicken Sie auf __Commit__ und dann auf __Stage & Commit__
4. Warten Sie bis die Build-Pipeline Ihre Seite gebaut hat und diese auf GitLab Pages deployt wurde.
5. Öffnen Sie dann mit einem Browser: <pre>http://[vorname.nachname].pages.mylab.th-luebeck.de/barebones/</pre>
6. Sie sollten nun ein gut erkennbares Schachbrett erkennen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

___Tipp:__ Probieren Sie erst den Browser Firefox aus, sollten Sie keine Änderungen sehen. Browser wie Chrome, Safari, Edge,
etc. cachen aus Performancegründen häufig recht "optimistisch" - insbesondere Änderungen an CSS und JS (Dart) Dateien werden
nicht immer vom Webserver nachgeladen (da sich diese selten ändern!)._

Das Resultat sollte in etwa wie [hier](http://nane.kratzke.pages.mylab.th-luebeck.de/barebones/) aussehen.