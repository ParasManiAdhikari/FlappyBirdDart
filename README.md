An absolute bare-bones web app.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Erste Schritte

Benutzen Sie dieses Projekt als Ausgangspunkt für Ihre eigenen Projekte.

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
6. Warten Sie bis die Build-Pipeline ihre Aufgabe abgeschlossen hat und Ihre Seite auf GitLab Pages deployt wurde.
7. Navigieren Sie dannn mit einem Browser auf: http://[vorname.nachname].pages.mylab.th-luebeck.de/chess/
8. Sie sollten nun eine unstyled Tabelle (Schachbrett) sehen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

### Stylen Sie das Schachbrett

1. Öffnen Sie in der __WebIDE__ die Datei: __web/style.css__
2. Ergänzen Sie die folgenden CSS Regeln
    ```CSS
    #chess #td {
        font-size: 20px;
        width: 30px;
        height: 30px;
        background: lightgrey;
    }

    #chess tr:nth-child(2n + 1) td:nth-child(2n + 1),
    #chess tr:nth-child(2n + 2) td:nth-child(2n + 2) {
        background: black;
        color: white;
    }
    ```
