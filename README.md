# 1. Bare-bones webapp

Benutzen Sie dieses Projekt bitte als Ausgangspunkt für Ihre erste Aufgabe. Es ist so konfiguriert, dass Sie einfache

- Dart 2 Web-Projekte

mit einer Build-Pipeline deployen können. Das Repository für Ihr Projekt wird analog aufgebaut sein und Ihnen für Ihr Team bereitgestellt werden.

In den folgenden Schritten lernen Sie:

- Wie Sie mit einem GitLab Projekt umgehen.
- Wie Sie die Web-IDE von GitLab für einfache Änderungen nutzen können.
- Wie Sie mit CSS Regeln HTML-Dokumente gestalten können.
- Wie Sie mit Dart den DOM-Tree manipulieren können.
- Wie Sie GitLab CI dazu nutzen können, ein Projekt automatisiert zu bauen und in Kubernetes zu deployen.
- Wie Sie lokal Änderungen vornehmen und testen zu können.
- Wie Sie lokale Änderungen mittels VSCode + Git committen und an Gitlab Pushen können, um die Build-Pipeline auch von Ihrem lokalen Rechner aus anstoßen zu können.

Am Ende sollten Sie ein Schachbrett gestaltet und aufgebaut haben. Das ist sicher noch sehr weit von dem zu entwickelnden Spiel entfernt, aber diese Basis-Kenntnisse sollen Ihnen helfen, schnell Ihren persönlichen Einstieg in Ihr Spielprojekt zu finden.

## 1.1. Inhalt

- [1. Bare-bones webapp](#1-bare-bones-webapp)
  - [1.1. Inhalt](#11-inhalt)
  - [1.2. Aufbau des Projektes](#12-aufbau-des-projektes)
  - [1.3. Installation von Lens](#13-installation-von-lens)
- [2. Aufgaben](#2-aufgaben)
  - [2.1. Starten Sie die Web-IDE und legen Sie die Struktur eines Schachbretts mit Hilfe von HTML an](#21-starten-sie-die-web-ide-und-legen-sie-die-struktur-eines-schachbretts-mit-hilfe-von-html-an)
  - [2.2. Gestalten Sie das Schachbrett mit Hilfe von CSS](#22-gestalten-sie-das-schachbrett-mit-hilfe-von-css)
  - [2.3. Platzieren Sie Schachfiguren auf dem Schachbrett (im DOM-Tree) mit Hilfe von Dart](#23-platzieren-sie-schachfiguren-auf-dem-schachbrett-im-dom-tree-mit-hilfe-von-dart)
  - [2.4. Stellen Sie Ihr Schachbrett noch vom Kopf auf die Füße](#24-stellen-sie-ihr-schachbrett-noch-vom-kopf-auf-die-füße)
  - [2.5. Gestalten Sie das Schachbrett mit Hilfe von CSS](#25-gestalten-sie-das-schachbrett-mit-hilfe-von-css)
  - [2.6. Platzieren Sie Schachfiguren auf dem Schachbrett (im DOM-Tree) mit Hilfe von Dart](#26-platzieren-sie-schachfiguren-auf-dem-schachbrett-im-dom-tree-mit-hilfe-von-dart)
  - [2.7. Stellen Sie Ihr Schachbrett noch vom Kopf auf die Füße](#27-stellen-sie-ihr-schachbrett-noch-vom-kopf-auf-die-füße)
  - [2.8. Arbeiten Sie lokal](#28-arbeiten-sie-lokal)
- [3. Schlussbemerkung](#3-schlussbemerkung)

## 1.2. Aufbau des Projektes

- `web/`: In diesem Ordner befindet sich Ihr Dart-, HTML- und CSS-Code. **Dies ist der für Sie primär relevante Ordner.**
- `deploy/`: Hier finden Sie Kubernetes Manifest-Dateien, die für das Deployment erforderlich sind. Inhalte dieses Ordners müssen durch Sie in aller Regel nicht angepasst werden.
- `README.md`: Diese Datei. Sie ist in [Markdown](https://git.mylab.th-luebeck.de/help/user/markdown.md) formatiert, und wird auf der Hauptseite des Projektes direkt angezeigt. Im Verlaufe Ihres Projekts können Sie hier Dokumentation bzw. ein "Getting Started" Ihres Spieles unterbringen.
- `pubspec.yaml` und `analysis_options.yaml`: Konfiguration des Dart-Builds bzw. der statischen Code-Analyse.
- `.gitlab-ci.yml` und `Dockerfile`: Anweisungen an GitLab, wie Ihr Projekt mittels einer Deployment Pipeline gebaut auf deployed werden soll. Der Build-Prozess wird bei jeder Veränderung (Push/Commit) des Projektes angestoßen. Diese Dateien müssen durch Sie in aller Regel nicht angepasst werden.
- `.gitignore`: Hier eingetragene Dateien und Pfade werden von Git, z.B. bei der Ausführung von `git status` oder `git add .`, ignoriert. Sie können diese Datei nach belieben erweitern.

In diesem Repository wurden ferner Umbegungsvariablen (`Variables`) unter [CI/CD-Settings](../../settings/ci_cd) hinterlegt, die von der Deployment-Pipeline dazu genutzt werden, Ihr Projekt in einen [Kubernetes](https://kubernetes.io)-Cluster zu deployen. Dies entspricht üblichen DevOps-Prinzipien.

```
        +----------+                                        
    +-> |  GitLab  | -Commits-+ 
    |   +----------+          |                               +-------------+
SIE-+                         +-> | Deployment Pipeline | --> | K8s Cluster | <-- WWW
    |   +----------+          |                               +-------------+
    +-> | lok. IDE | -Commits-+
        +----------+
```

Passen Sie daher bitte weder Umgebungsvariablen noch die Deployment-Pipeline an. Es sei denn, Sie wissen genau was Sie tun!

## 1.3. Installation von Lens

Um einen Einblick in das Deployment auf dem Cluster nehmen zu können, installieren Sie hierzu bitte lokal auf Ihrem Rechner die Kubernetes-IDE [Lens](https://k8slens.dev/).

![Lens](lens.png)

Starten Sie Lens und fügen Sie der IDE eine erforderliche `kubeconfig`-Datei hinzu, um auf Ihren Cluster zugreifen zu können. Sie finden diese Datei in den [CI/CD Settings](../../settings/ci_cd) dieses Repositories unter `Variables` unter dem Schlüssel `KUBECONFIG`. 

**Diese persönlichen Zugangsdaten zum Kubernetes Cluster sind vertraulich, nur für diesen Kurs zu nutzen und durch Sie in keinem Falle weiterzugeben.**

1. Kopieren Sie sich in GitLab ([CI/CD Settings](../../settings/ci_cd)) den Inhalt der CI/CD-Variable `KUBECONFIG` in Ihre Zwischenablage (`CTRL-C/CMD-C`).
2. Starten Sie Lens: `Add Cluster (großes +) -> Paste as text` Kopieren Sie nun den Inhalt aus der Zwischenablage mittels `CTRL-V/CMD-V`hinein.
3. Klicken Sie anschließen auf `Add cluster`.

Sie sollten dann (nach kurzer Synchronisation) Ihren Namespace in dem für Sie bereitgestellten K8s-Cluster sehen. In diesen Namespace deployed die Pipeline Ihre Applikation.

# 2. Aufgaben

## 2.1. Starten Sie die Web-IDE und legen Sie die Struktur eines Schachbretts mit Hilfe von HTML an

1. Navigieren Sie zu __Repository__ -> __Files__
2. Klicken Sie auf __Web-IDE__
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
7. Öffen Sie dann auf Ihrem Rechner **Lens** und geben dort im Terminal folgendes ein: 
   ```Bash
   kubectl port-forward svc/master-webapp-svc 8888:80
   ```
   Damit leiten Sie Ihr Webprojekt auf den lokalen Port 8888 auf Ihren Rechner um. Probieren Sie es aus. Unter [http://localhost:8888](http://localhost:8888) sollten Sie das Resultat sehen.
8. Sie sollten nun eine unstyled Tabelle (Schachbrett) sehen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

> **Hinweis 1:**
> Wir werden Ihnen noch zeigen, wie Sie Ihre Web-Applikation auch mittels einer `Ingress`-Ressource Cluster-extern im weltweiten Netz exponieren können. Hierfür benötigen wir allerdings HTTPS-Zertifikate. Da wir diese automatisiert mittels [Letsencrypt](https://letsencrypt.org/de/) erzeugen und dort ein Limit von 50 Zertifikatausstellungen pro Woche und Domain besteht, werden wir dies erst machen, wenn Sie Ihre Spiele in den Teams bereitstellen müssen. Dann liegen wir sicher unterhalb der Letsencrypt Quotas. Bis dahin werden wir uns mit Port-Forwarding begnügen.

> **Hinweis 2:**
> Das Port Forwarding können Sie im Terminal mittels `Ctrl-C` beenden. Wenn Sie eines neues Deployment über die Pipeline triggern, müssen Sie anschließend auch das Port-Forwarding beenden, da dieses ansonsten im Nirwana (d.h. dem letzten dann ersetzten und nicht mehr existenten Deployment) endet.

## 2.2. Gestalten Sie das Schachbrett mit Hilfe von CSS

1. Öffnen Sie in der __Web-IDE__ die Datei: __web/style.css__
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
5. Öffen Sie dann **Lens**. Beenden Sie ggf. ein noch existentes Port-Forwarding im Lens Terminal mittels `Ctrl-C` und starten ein neues, um das Resultat unter [http://localhost:8888](http://localhost:8888) zu sehen:
   ```Bash
   kubectl port-forward svc/master-webapp-svc 8888:80
   ```
6. Sie sollten nun ein gut erkennbares Schachbrett erkennen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

___Tipp:__ Probieren Sie erst den Browser Firefox aus, sollten Sie keine Änderungen sehen. Browser wie Chrome, Safari, Edge,
etc. cachen aus Performancegründen häufig recht "optimistisch" - insbesondere Änderungen an CSS und JS (Dart) Dateien werden
nicht immer vom Webserver nachgeladen (da sich diese selten ändern!). Meist hilft bei Chrome und Konsorten auch die Tastenkombination
`Shift` + `Strg` + `r` (`Shift` + `Cmd` + `r` auf Mac), um die Webseite am Browsercache vorbei neu zu laden._

## 2.3. Platzieren Sie Schachfiguren auf dem Schachbrett (im DOM-Tree) mit Hilfe von Dart

1. Öffnen Sie in der __Web-IDE__ die Datei: __web/main.dart__
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
5. Öffen Sie dann **Lens**. Beenden Sie ggf. ein noch existentes Port-Forwarding und starten ein neues, um das Resultat unter [http://localhost:8888](http://localhost:8888) zu sehen:
   ```Bash
   kubectl port-forward svc/master-webapp-svc 8888:80
   ```
6. Sie sollten nun ein gut erkennbares Schachbrett erkennen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

___Tipp:__ Probieren Sie erst den Browser Firefox aus, sollten Sie keine Änderungen sehen. Browser wie Chrome, Safari, Edge,
etc. cachen aus Performancegründen häufig recht "optimistisch" - insbesondere Änderungen an CSS und JS (Dart) Dateien werden
nicht immer vom Webserver nachgeladen (da sich diese selten ändern!). Meist hilft bei Chrome und Konsorten auch die Tastenkombination
`Shift` + `Strg` + `r` (`Shift` + `Cmd` + `r` auf Mac), um die Webseite am Browsercache vorbei neu zu laden._

Das Resultat sollte in etwa wie [hier](https://webtech.mylab.th-luebeck.de/chessboard) aussehen.

## 2.4. Stellen Sie Ihr Schachbrett noch vom Kopf auf die Füße

Ihr Resultat wird vermutlich nicht exakt wie diese [Grundstellung](https://webtech.mylab.th-luebeck.de/chessboard) aussehen. Ihr Schachbrett steht noch irgendwie Kopf. Korrigieren Sie die Copy/Paste Snippets, die Sie in die Dateien

1. `index.html` (Versuchen Sie die Nummerierung der Zeilen anzupassen.)
2. `style.css` (Versuchen Sie die Farbgebung des Schachbretts anzupassen.)
3. `main.dart` (Versuchen Sie rauszufinden, welche Zeilen für welche Figuren verantwortlich sind und passen Sie diese an.)

eingefügt haben, so, dass die "normale" Grundstellung im Schach entsteht. Wenn Sie damit fertig sind, wenden Sie sich bitte an einen Betreuer und erklären:

1. Welche Änderungen in der `index.html` erforderlich waren und warum?
2. Welche Änderungen in der `style.css` erforderlich waren und warum?
3. Welche Änderungen in der `main.dart` erforderlich waren und warum?

Konnten Sie die Fragen beantworten, sind Sie fertig für heute und können sich fragen, wie Sie Ihre Erkenntnisse für Ihr zu entwick## Starten Sie die WebIDE und legen Sie die Struktur eines Schachbretts mit Hilfe von HTML an

1. Navigieren Sie zu __Repository__ -> __Files__
2. Klicken Sie auf __Web-IDE__
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
7. Öffen Sie dann **Lens**. Beenden Sie ggf. ein noch existentes Port-Forwarding und starten ein neues, um das Resultat unter [http://localhost:8888](http://localhost:8888) zu sehen:
   ```Bash
   kubectl port-forward svc/master-webapp-svc 8888:80
   ```
8. Sie sollten nun eine unstyled Tabelle (Schachbrett) sehen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

## 2.5. Gestalten Sie das Schachbrett mit Hilfe von CSS

1. Öffnen Sie in der __Web-IDE__ die Datei: __web/style.css__
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
5. Öffen Sie dann **Lens**. Beenden Sie ggf. ein noch existentes Port-Forwarding und starten ein neues, um das Resultat unter [http://localhost:8888](http://localhost:8888) zu sehen:
   ```Bash
   kubectl port-forward svc/master-webapp-svc 8888:80
   ```
6. Sie sollten nun ein gut erkennbares Schachbrett erkennen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

___Tipp:__ Probieren Sie erst den Browser Firefox aus, sollten Sie keine Änderungen sehen. Browser wie Chrome, Safari, Edge,
etc. cachen aus Performancegründen häufig recht "optimistisch" - insbesondere Änderungen an CSS und JS (Dart) Dateien werden
nicht immer vom Webserver nachgeladen (da sich diese selten ändern!). Meist hilft bei Chrome und Konsorten auch die Tastenkombination
`Shift` + `Strg` + `r` (`Shift` + `Cmd` + `r` auf Mac), um die Webseite am Browsercache vorbei neu zu laden._

## 2.6. Platzieren Sie Schachfiguren auf dem Schachbrett (im DOM-Tree) mit Hilfe von Dart

1. Öffnen Sie in der __Web-IDE__ die Datei: __web/main.dart__
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
5. Öffen Sie dann **Lens**. Beenden Sie ggf. ein noch existentes Port-Forwarding und starten ein neues, um das Resultat unter [http://localhost:8888](http://localhost:8888) zu sehen:
   ```Bash
   kubectl port-forward svc/master-webapp-svc 8888:80
   ```
6. Sie sollten nun ein gut erkennbares Schachbrett erkennen (wenn nicht, wenden Sie sich bitte an einen Betreuer).

___Tipp:__ Probieren Sie erst den Browser Firefox aus, sollten Sie keine Änderungen sehen. Browser wie Chrome, Safari, Edge,
etc. cachen aus Performancegründen häufig recht "optimistisch" - insbesondere Änderungen an CSS und JS (Dart) Dateien werden
nicht immer vom Webserver nachgeladen (da sich diese selten ändern!). Meist hilft bei Chrome und Konsorten auch die Tastenkombination
`Shift` + `Strg` + `r` (`Shift` + `Cmd` + `r` auf Mac), um die Webseite am Browsercache vorbei neu zu laden._

Das Resultat sollte in etwa wie [hier](https://webtech.mylab.th-luebeck.de/chessboard) aussehen.

## 2.7. Stellen Sie Ihr Schachbrett noch vom Kopf auf die Füße

Ihr Resultat wird vermutlich nicht exakt wie diese [Grundstellung](https://webtech.mylab.th-luebeck.de/chessboard) aussehen. Ihr Schachbrett steht noch irgendwie Kopf. Korrigieren Sie die Copy/Paste Snippets, die Sie in die Dateien

1. `index.html` (Versuchen Sie die Nummerierung der Zeilen anzupassen.)
2. `style.css` (Versuchen Sie die Farbgebung des Schachbretts anzupassen.)
3. `main.dart` (Versuchen Sie rauszufinden, welche Zeilen für welche Figuren verantwortlich sind und passen Sie diese an.)

eingefügt haben, so, dass die "normale" Grundstellung im Schach entsteht. Wenn Sie damit fertig sind, wenden Sie sich bitte an einen Betreuer und erklären:

1. Welche Änderungen in der `index.html` erforderlich waren und warum?
2. Welche Änderungen in der `style.css` erforderlich waren und warum?
3. Welche Änderungen in der `main.dart` erforderlich waren und warum?

Konnten Sie die Fragen beantworten, sind Sie fertig für heute und können sich fragen, wie Sie Ihre Erkenntnisse für Ihr zu entwickelndes Spiel nutzen können ;-)

## 2.8. Arbeiten Sie lokal

Sie haben gemerkt, dass die Build-Pipeline immer recht viel Zeit in Anspruch nimmt. Es ist daher für die tägliche Projektarbeit sinnvoll, lokal auf Ihrem eigenen Rechner arbeiten zu können und einzelne Anpassungen vornehmen zu können und diese direkt lokal austesten zu können. Erst wenn Ihre Änderungen lokal funktionieren, sollten Sie dann in das Repository pushen und so die oben gezeigte Build-Pipeline anstoßen.

Für Ihr Webtech Projekt wird grundsätzlich folgendes Setting empfohlen.

- Installieren Sie [git](https://git-scm.com/downloads)
- Installieren Sie das [Dart SDK](https://dart.dev/get-dart)
- Installieren Sie die IDE [Visual Studio Code](https://code.visualstudio.com) inkl. der [Dart Extension](https://flutter.dev/docs/get-started/editor?tab=vscode)
- Installieren Sie [Lens](https://k8slens.dev) (für diesen Schritt nicht erforderlich)

Lokales Arbeiten:

1. Klonen Sie dann [Ihr Repository](./) in der [Gitlab Web-UI](./) unter `Klonen -> Open in your IDE (Visual Studio Code)`. Es öffnet sich dann VSCode und fragt, ob Sie dieses Repository klonen und lokal bei sich speichern wollen. Bejahen Sie dies.
2. Öffnen Sie dann in VSCode eine Shell mittels `Terminal -> Neues Terminal`.
3. Geben Sie in diesem Terminal folgendes ein:
   ```Bash
   > dart pub global activate webdev
   > pub get
   > webdev serve
   ```
4. Dies startet einen Build Daemon (genau derselbe wie in der Build-Pipeline). Dieser überwacht das Verzeichnis und alle in diesem Verzeichnis befindlichen Dateien und startet unter [http://127.0.0.1:8080](http://127.0.0.1:8080) einen Webserver unter dem Ihre Webapp lokal abgerufen und getestet werden kann. Öffnen Sie die URL mit Ihrem Browser, um es auszuprobieren.
5. Probieren Sie es aus. Fügen Sie bspw. der `index.html` Datei folgende Überschrift hinzu `<h1>Local Test</h1>` und speichern Sie die Datei. Beobachten Sie das Terminal. Die Änderung wird erkannt, eine Rekompilierung angestoßen. Anschließend können Sie unter [http://127.0.0.1:8080](http://127.0.0.1:8080) die Änderung lokal sehen.
6. Klicken Sie in VSCode nun auf den GIT-Reiter (Quellcode-Verwaltung). Dort finden Sie unter `Änderungen` alle Änderungen, die Sie zum Stand gemacht haben, den Sie im Schritt 1 herunter geladen haben.
7. Übernehmen Sie nun mittels `+` alle Änderungen als `gestagte Änderungen`. Damit merken Sie diese für einen Commit in GIT vor. Geben Sie nun eine Commit-Nachricht ein, z.B. `Mein erster Commit`. Klicken Sie auf das "Häkchen". Dies committed alle Änderung in die lokale Version ihres Repositories.
8. Um diese lokalen Änderungen auch an den Gitlab Server zu übertragen, müssen sie diese "pushen". Klicken Sie hierzu in VSCode in der unteren Statusleiste neben `master` auf das Synchronisationsfeld. Dort sollten 0 Commits zum Pull und 1 Commits zum Push stehen. Durch Klicken der Synchronisationsfeldes können Sie diese Änderungen nun an das zentrale Repository übertragen. Dieser Vorgang stößt die Build-Pipeline an und Sie können Ihre lokalen Änderungen zentral im Kubernetes Cluster bereitstellen.
9. Vollziehen Sie gerne in Lens und in der [CI/CD Pipeline](-/pipelines) nach, dass Ihre Änderung erfolgreich gepushed wurde und die Build-Pipeline anläuft.

# 3. Schlussbemerkung

Gegenstand des Moduls Webtechnologie-Projekt sind Webtechnologien und nicht GitLab, Deployment Pipelines und Kubernetes. Diese Technologien werden zur Automatisierung von Deployments und einen angenehmeren Workflow genutzt, müssen durch Sie aber in aller Regel nicht angepasst werden. Wer dazu mehr hören möchte, sei auf die Mastermodule *Cloud-native Programmierung* und *Cloud-native Architekturen* des Masterstudiengangs *Informatik/Verteilte Systeme* verwiesen ;-)
