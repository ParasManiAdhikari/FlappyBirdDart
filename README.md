## An absolute bare-bones web app

_Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE)._

Benutzen Sie dieses Projekt als Ausgangspunkt für Ihre eigenen Projekte.
Es ist so konfiguriert, dass Sie einfache

- Dart 2 Projekte

mit einer einfachen Build-Pipeline auf GitLab-Pages deployen können.

## Erste Schritte

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

1. Loggen Sie sich in GitLab ein.
2. Navigieren Sie zu __New Repository__ -> __Import Repository__ -> __Repo by URL__
3. Geben Sie die folgenden Daten an:
    - Git Repository URL: https://bitbucket.org/nanekratzke/barebones.git
    - Project name: chess
    - Project slug: chess
    - Visibility level: internal
4. Klicken Sie auf __Create project__
5. Warten Sie den Import Process ab (kann etwas dauern)

### Starten Sie die WebIDE

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
7. Navigieren Sie dannn mit einem Browser auf: http://[vorname.nachname].pages.mylab.th-luebeck.de/chess/
8. Sie sollten nun eine unstyled Tabelle (Schachbrett) sehen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

### Stylen Sie das Schachbrett

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
5. Navigieren Sie dannn mit einem Browser auf: http://[vorname.nachname].pages.mylab.th-luebeck.de/chess/
6. Sie sollten nun ein gut erkennbares Schachbrett erkennen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

### Nutzen Sie Dart um Schachfiguren auf ihrem Schachbrett zu platzieren

1. Öffnen Sie in der __WebIDE__ die Datei: __web/main.dart__
2. Ergänzen Sie in der `main()`-Methode folgende Codezeilen.
    ```Dart
    // White
    querySelectorAll('#chess tr:nth-child(3) td:nth-child(n+2)').forEach((td) { td.innerHtml = "&#9817;"; });
    querySelectorAll('#chess tr:nth-child(2) td:nth-child(2), #chess tr:nth-child(2) td:nth-child(9)').forEach((td) { td.innerHtml = "&#9814;"; });
    querySelectorAll('#chess tr:nth-child(2) td:nth-child(3), #chess tr:nth-child(2) td:nth-child(8)').forEach((td) { td.innerHtml = "&#9816;"; });
    querySelectorAll('#chess tr:nth-child(2) td:nth-child(4), #chess tr:nth-child(2) td:nth-child(7)').forEach((td) { td.innerHtml = "&#9815;"; });
    querySelector('#chess tr:nth-child(2) td:nth-child(5)').innerHtml = "&#9812;";
    querySelector('#chess tr:nth-child(2) td:nth-child(6)').innerHtml = "&#9813;";

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
5. Navigieren Sie dannn mit einem Browser auf: http://[vorname.nachname].pages.mylab.th-luebeck.de/chess/
6. Sie sollten nun ein gut erkennbares Schachbrett erkennen (wenn nicht, wenden Sie sich bitte an einen Betreuer).