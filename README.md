
# A bare-bones web app

Benutzen Sie dieses Projekt als Ausgangspunkt für die erste Aufgabe. Es ist so konfiguriert, dass Sie einfache

- Dart 2 Web-Projekte

mit einer einfachen Build-Pipeline deployen können. Das Repository für Ihr Projekt werden Sie analog forken und aufbauen.

In den folgenden Schritten lernen Sie:

- Wie Sie ein neues GitLab Projekt anlegen.
- Wie Sie die WebIDE von GitLab für einfache Änderungen nutzen können.
- Wie Sie mit CSS Regeln HTML-Dokumente gestalten können.
- Wie Sie mit Dart den DOM-Tree manipulieren können.
- Wie Sie GitLab CI dazu nutzen können, ein Projekt automatisiert zu bauen und in Kubernetes zu deployen.

Am Ende sollten Sie ein Schachbrett gestaltet und aufgebaut haben. Das ist sicher noch sehr weit von dem zu entwickelnden Spiel entfernt, aber diese Basis-Kenntnisse sollen Ihnen helfen schnell Ihren persönlichen Einstieg in Ihr Spielprojekt zu finden.

## Aufbau des Projektes

- `web/`: In diesem Ordner befindet sich Ihr Dart-, HTML- und CSS-Code
- `README.md`: Diese Datei. Sie ist in [Markdown](https://git.mylab.th-luebeck.de/help/user/markdown.md) formatiert, und wird auf der Hauptseite des Projektes direkt angezeigt. Im Laufe des Semesters können Sie hier Dokumentation bzw. ein "Getting Started" Ihres Spieles unterbringen.
- `pubspec.yaml` und `analysis_options.yaml`: Konfiguration des Dart-Builds bzw. der statischen Code-Analyse.
- `.gitlab-ci.yml` und `Dockerfile`: Anweisungen an GitLab, wie Ihr Projekt mittels einer Deployment Pipeline gebaut auf deployed werden soll. Der Build-Prozess wird bei jeder Veränderung (Push/Commit) des Projektes angestoßen.
- `.gitignore`: Hier eingetragene Dateien und Pfade werden von Git, z.B. bei der Ausführung von `git status` oder `git add .`, ignoriert. Sie können diese Datei nach belieben erweitern.

## Forken Sie ein neues Projekt

1. Loggen Sie sich in [GitLab](https://git.mylab.th-luebeck.de) ein (dieselben Access credentials wie Moodle).
2. Navigieren Sie in einem Browser zu: [https://git.mylab.th-luebeck.de/webtech/barebones](https://git.mylab.th-luebeck.de/webtech/barebones)
4. Klicken Sie auf __Fork__
3. Wählen Sie Ihren Namen als Namespace

Es sollte nun unter Ihrem Account ein neues Projekt namens "barebones" angelegt worden sein
(falls nicht, wenden Sie sich an einen Betreuer).

## Vorbereitung der Build-Pipeline

Im Moodle-Kurs wurden Ihnen Access Credentials hinterlegt, die Sie dazu nutzen können, Ihr Projekt in einem sogenannten [Kubernetes](https://kubernetes.io)-Cluster zu deployen. Dies entspricht mittlerweile einem üblichen DevOps-Vorgehen. Mit den nächsten Schritten dieses Abschnitts, werden Sie hierzu Gitlab mit diesem Cluster über eine für Sie vorbereitete Deployment Pipeline verbinden.

```
        +--------+                                        +-------------+
SIE --> | GitLab | -Commits-> | Deployment Pipeline | --> | K8s Cluster | <-- WWW
        +--------+                                        +-------------+
```

1. Laden Sie sich Ihre `kubeconfig` Datei im [Moodle-Kurs](https://lernraum.th-luebeck.de/course/view.php?id=266) herunter.
2. Erstellen Sie anschließend in Gitlab unter `Einstellungen -> Repository -> Bereitstellungstoken` für das geforkte Repository einen Bereitstellungstoken, um selbstgebaute Container Images deployen zu können.
    - **Name:** `Registry read access (deployment)`
    - **Username:** `image-registry` (bitte exakt so!)
    - **Scope:** `read-registry` (nicht mit read repository verwechseln!)
    - Klicken Sie anschließend auf Bereitstellungstoken erstellen und kopieren Sie sich dieses geheime Token in die Zwischenablage!
3. Hinterlegen Sie nun für Gitlab Build-Pipelines dieses geheime Token unter `Einstellungen -> CI/CD -> Variables (Aufklappen) -> ADD VARIABLE` als CI/CD-Variable.
    - **Key:** `CI_REGISTRY_TOKEN` (exakt so)
    - **Value:** Fügen Sie hier das geheime Token (Schritt 2) aus der Zwischenablage ein.
    - **Type:** `Variable` (nichts anderes)
    - **Flags:** Selektieren Sie `Mask Variable` damit das geheime Token in Log-Dateien maskiert wird.
4. Hinterlegen Sie in Ihrem geforkten GitLab-Repository nun die `kubeconfig`-Datei als CI-Environment-Variable mittels `Einstellungen -> CI/CI -> Variables (Aufklappen) -> ADD VARIABLE` (setzen Sie hierfür folgende Werte)
    - **Key:** `KUBECONFIG` (Exakt so eingeben)
    - **Value:** Inhalt der kubeconfig (z.B. mittels Copy-Paste aus Editor)
    - **Typ:** `File` (Auswählen, WICHTIG!!!)

## Starten Sie die WebIDE und legen Sie die Struktur eines Schachbretts mit Hilfe von HTML an

1. Navigieren Sie zu __Repository__ -> __Files__
2. Klicken Sie auf __WebIDE__
3. Öffnen Sie die Datei: __web/index.html__
4. Fügen Sie __hinter__ `<div id="output"></div>` folgenden Inhalt ein:
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
5. Klicken Sie auf __Commit__ wählen dann __Commit to master branch__ und schließen mit __Commit__ ab.
6. Warten Sie, bis die Build-Pipeline durchlaufen wurde. Sie können den Buildprozess wie folgt nachverfolgen:
   - Navigieren Sie unter Ihrem Projekt (evtl. müssen Sie dazu die Web-IDE verlassen) zu __CI/CD__ -> __Pipelines__
       - Es wird eine Tabelle aller vergangenen, und auch des aktuellen Buildprozesses angezeigt. Das blaue runde Icon in der Spalte "Stages" zeigt an, dass der build läuft. Sobald dieser abgeschlossen ist, wird stattdessen ein grünes Häkchen angezeigt.
   - Klicken Sie bei dem obersten Eintrag auf das blaue Icon in der Spalte "Stages"
   - Klicken Sie gerne auf die einzlnen Jobs. Sie sehen dort die Konsolenausgaben der einzelnen Buildjobs (ggf. für Fehlersuchen ganz hilfreich).
7. Öffnen Sie dann mit einem Browser: 
   ```
   https://webapp-[userid]-master.webtech.th-luebeck.dev
   ```
   Als `userid` geben Sie bitte Ihre Gitlab User Id an. Diese finden Sie unter den GitLab-[Profileinstellungen](https://git.mylab.th-luebeck.de/-/profile) `-> User ID`.
8. Sie sollten nun eine unstyled Tabelle (Schachbrett) sehen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

## Gestalten Sie das Schachbrett mit Hilfe von CSS

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
3. Klicken Sie auf __Commit__ wählen dann __Commit to master branch__ und schließen mit __Commit__ ab.
4. Warten Sie bis die Build-Pipeline durchlaufen wurde.
5. Öffnen Sie dann mit einem Browser: <pre>https://webapp-[userid]-master.webtech.th-luebeck.dev</pre>
6. Sie sollten nun ein gut erkennbares Schachbrett erkennen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

___Tipp:__ Probieren Sie erst den Browser Firefox aus, sollten Sie keine Änderungen sehen. Browser wie Chrome, Safari, Edge,
etc. cachen aus Performancegründen häufig recht "optimistisch" - insbesondere Änderungen an CSS und JS (Dart) Dateien werden
nicht immer vom Webserver nachgeladen (da sich diese selten ändern!). Meist hilft bei Chrome und Konsorten auch die Tastenkombination
`Shift` + `Strg` + `r` (`Shift` + `Cmd` + `r` auf Mac), um die Webseite am Browsercache vorbei neu zu laden._

## Platzieren Sie Schachfiguren auf dem Schachbrett (im DOM-Tree) mit Hilfe von Dart

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
3. Klicken Sie auf __Commit__ wählen dann __Commit to master branch__ und schließen mit __Commit__ ab.
4. Warten Sie bis die Build-Pipeline durchlaufen wurde.
5. Öffnen Sie dann mit einem Browser: <pre>https://webapp-[userid]-master.webtech.th-luebeck.dev</pre>
6. Sie sollten nun ein gut erkennbares Schachbrett erkennen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

___Tipp:__ Probieren Sie erst den Browser Firefox aus, sollten Sie keine Änderungen sehen. Browser wie Chrome, Safari, Edge,
etc. cachen aus Performancegründen häufig recht "optimistisch" - insbesondere Änderungen an CSS und JS (Dart) Dateien werden
nicht immer vom Webserver nachgeladen (da sich diese selten ändern!). Meist hilft bei Chrome und Konsorten auch die Tastenkombination
`Shift` + `Strg` + `r` (`Shift` + `Cmd` + `r` auf Mac), um die Webseite am Browsercache vorbei neu zu laden._

Das Resultat sollte in etwa wie [hier](https://webtech.mylab.th-luebeck.de/chessboard) aussehen.

## Stellen Sie Ihr Schachbrett noch vom Kopf auf die Füße

Ihr Resultat wird vermutlich nicht exakt wie diese [Grundstellung](https://webtech.mylab.th-luebeck.de/chessboard) aussehen. Ihr Schachbrett steht noch irgendwie Kopf. Korrigieren Sie die Copy/Paste Snippets, die Sie in die Dateien

1. `index.html` (Versuchen Sie die Nummerierung der Zeilen anzupassen.)
2. `style.css` (Versuchen Sie die Farbgebung des Schachbretts anzupassen.)
3. `main.dart` (Versuchen Sie rauszufinden, welche Zeilen für welche Figuren verantwortlich sind und passen Sie diese an.)

eingefügt haben, so, dass die "normale" Grundstellung im Schach entsteht. Wenn Sie damit fertig sind, wenden Sie sich bitte an einen Betreuer und erklären:

1. Welche Änderungen in der `index.html` erforderlich waren und warum?
2. Welche Änderungen in der `style.css` erforderlich waren und warum?
3. Welche Änderungen in der `main.dart` erforderlich waren und warum?

Konnten Sie die Fragen beantworten, sind Sie fertig für heute und können sich fragen, wie Sie Ihre Erkenntnisse für Ihr zu entwickelndes Spiel nutzen können ;-)

## Nerd Stuff (optional)

Wer mag, kann einen Einblick in das Deployment auf dem Cluster mittels der Kubernetes-IDE Lens nehmen. Installieren Sie hierzu bitte lokal auf Ihrem Rechner die Kubernetes-IDE [Lens](https://k8slens.dev/).

![Lens](lens.png)

Starten Sie Lens und fügen Sie der IDE, die Ihnen in Moodle bereitgestellte `kubeconfig`-Datei hinzu, um auf Ihren Cluster zugreifen zu können. Dies ist dieselbe Datei, die Sie auch der Deployment-Pipeline bekannt gemacht haben.

1. `Add Cluster (großes +) -> Paste as text`
2. Kopieren Sie nun den Inhalt der `kubeconfig` hinein.
3. Klicken Sie anschließen auf `Add cluster`.

Sie sollten dann Ihren Namespace in dem für Sie bereitgestellten K8s-Cluster sehen.

__Hinweis:__

Gegenstand des Moduls Webtechnologie-Projekt sind Webtechnologien und nicht GitLab, Deployment Pipelines und Kubernetes. Diese Technologien werden zur Automatisierung von Deployments und einen angenehmeren Workflow genutzt, müssen durch Sie aber in aller Regel nicht angepasst werden. Wer dazu mehr hören möchte, sei auf die Mastermodule *Cloud-native Programmierung* und *Cloud-native Architekturen* des Masterstudiengangs *Informatik/Verteilte Systeme* verwiesen ;-)
