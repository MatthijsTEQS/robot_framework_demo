> !!! IMPORTANT !!!
>   Replace `SCREENSHOT 1 statt unten stehenden text`
>   Replace `URL TO REPO`
>   Replace `REPO URL ÄNDERN`


# Robot Framework und datengetriebene Tests mit Playwright, Docker und CI: Ein praxisnaher Einstieg

Robot Framework eignet sich für Teams, die automatisierte Tests lesbar formulieren und technische Browserdetails trotzdem sauber kapseln wollen. Das Framework verwendet eine tabellarische, schlüsselwortgetriebene Syntax. Ein Testfall liest sich dadurch eher wie eine fachliche Beschreibung als wie ein klassisches Automatisierungsskript.

Dieser Artikel hat zwei Schwerpunkte. Er zeigt erstens, wie Robot Framework, die Playwright-basierte Browser-Library, Docker und CI zu einem vollständigen UI-Testablauf zusammenspielen. Zweitens vergleicht er drei Ansätze für datengetriebene Tests: DataDriver mit CSV, einen eigenen Python-Reader für CSV und `RPA.Excel.Files` für Excel-Arbeitsmappen. Die Testlogik bleibt dabei gleich, während sich Datenquelle, Validierung, Testisolation und Darstellung im Report unterscheiden.

Das Demo-Projekt führt vom ersten vollständigen Testlauf bis zur Struktur einzelner Suites, Keywords und Datenquellen. Der Schwerpunkt liegt auf einer wartbaren Struktur, die sich auf größere Test-Suites übertragen lässt.

## Was ist Robot Framework?

Robot Framework ist ein in Python implementiertes, schlüsselwortgetriebenes Automatisierungsframework. Es wird vor allem für Akzeptanztests, Acceptance Test-Driven Development und Regressionstests eingesetzt. Der Kern des Frameworks kennt die zu testende Anwendung nicht. Er liest Testdaten, führt Keywords aus und erzeugt Logs sowie Reports. Die Verbindung zum Browser, zu einer API, einer Datenbank oder einem Betriebssystem erfolgt über Bibliotheken.

Diese Trennung ist zentral:

- Robot Framework steuert Ausführung, Variablen, Kontrollstrukturen und Reporting.
- Bibliotheken stellen technische Keywords bereit.
- Resource-Dateien kombinieren technische Keywords zu fachlichen Aktionen.
- Test-Suites beschreiben das erwartete Verhalten.

Im Projekt übernimmt die `Browser`-Library, die auf Playwright basiert, die Webautomatisierung. Zu den grundlegenden Robot-Konzepten gehören: Libraries importieren, Keywords aufrufen, Zustände prüfen und wiederverwendbare Abläufe in Resource-Dateien auslagern.

Robot Framework reduziert nicht den Bedarf an technischem Verständnis. Selektoren, asynchrone Browserzustände, Testdaten, Isolation und CI bleiben anspruchsvoll. Das Framework verschiebt diese Details aber aus den fachlichen Testfällen in klar abgegrenzte technische Schichten. Der Vorteil ist, dass sich Robot-Tests leichter mit dem Fachbereich besprechen lassen.

Wie diese Trennung in einem vollständigen Testprojekt umgesetzt wird, zeigt das folgende Demo-Projekt.

## Ziel und Umfang des Demo-Projekts

Das Repository testet ausschließlich die Weboberfläche des `OWASP Juice Shop`. Der Shop läuft lokal in einem Docker-Container. Robot Framework läuft direkt auf dem Entwicklungsrechner oder auf einem CI-Runner und greift über `http://127.0.0.1:3000` auf die Anwendung zu. Neben den fachlichen UI-Journeys demonstriert das Projekt mehrere Data-driven-Ansätze für denselben Suchtest. Dadurch lassen sich nicht nur die Datenformate, sondern auch ihre Auswirkungen auf Reports, Isolation und Wartung vergleichen.

Der Testumfang für dieses Demo-Projekt:

- Der Umfang ist auf UI-Tests beschränkt.
- Die Startseite lädt und zeigt Produktkarten.
- Eine Suche filtert den Katalog korrekt.
- Produktdetails lassen sich öffnen und schließen.
- Ein anonymer Warenkorb startet leer und zeigt hinzugefügte Mengen korrekt.
- Ein angemeldeter Benutzer kann eine Menge erhöhen, worauf sich der Gesamtpreis korrekt ändert.
- Ein neues Konto kann registriert werden.
- Gültige und ungültige Login-Versuche werden geprüft.

Um diesen Testumfang lokal und in der Pipeline reproduzierbar abzubilden, kombiniert das Projekt mehrere klar abgegrenzte Werkzeuge.

## Die verwendeten Werkzeuge

Das Projekt kombiniert folgende Werkzeuge mit getrennten Aufgaben:

- `Python` stellt die Laufzeit bereit und wird für kleine Hilfsskripte verwendet.
- `Robot Framework` führt Test-Suiten aus und erzeugt Ergebnisse.
- `Robot Framework Browser` steuert Chromium über Playwright.
- `Robot Framework DataDriver` erzeugt Tests aus CSV-Zeilen.
- `RPA.Excel.Files` liest Excel-Arbeitsmappen.
- `Docker Compose` startet eine definierte OWASP-Juice-Shop-Version, lokal und in der CI-Pipeline.
- `GitHub Actions` führt denselben Ablauf für Pull Requests und Änderungen auf `main` aus.
- `GitHub Pages` veröffentlicht die neuesten Testergebnisse.
- `Robocop` prüft, ob sich Robot-Dateien am offiziellen [Robot Framework Style Guide](https://docs.robotframework.org/docs/style_guide) orientieren.

## Testen ausführen

Mit diesen Bausteinen kann das Projekt zunächst vollständig gestartet werden, bevor die einzelnen Dateien und Konzepte im Detail betrachtet werden.

### Installation des Projekts

Der Quellcode des Demo-Projekts liegt in folgendem Repository:

>>>>>>>> URL TO REPO

Für den lokalen Lauf werden Python 3.11 oder neuer, Git, Node.js sowie Docker mit Docker-Compose-Unterstützung benötigt. Die folgenden Befehle werden aus einem Terminal ausgeführt. Nach dem Klonen müssen alle weiteren Befehle im Root-Verzeichnis des Repositorys laufen.

>>>>> REPO URL ÄNDERN
```bash
git clone <repository-url>
cd robot_framework_demo
python -m pip install -e .
rfbrowser init
```

`python -m pip install -e .` installiert die im Projekt definierten Python-Abhängigkeiten. `rfbrowser init` richtet die Node- und Playwright-Abhängigkeiten der Browser-Library ein.

Für Entwicklung und Linting kann die optionale Abhängigkeitsgruppe installiert werden:

```bash
python -m pip install -e ".[dev]"
python -m robocop format tests
```

Docker Compose startet die im Projekt definierte `OWASP Juice-Shop`-Version:

```bash
docker compose -f webshop_app/docker-compose.yml up -d
```

Der Webshop ist unter `http://127.0.0.1:3000` erreichbar.

### Den ersten Testlauf ausführen
Jetzt, da das Projekt installiert ist, kann ein erster Test durchgeführt werden.

Der folgende Befehl startet alle Robot-Suiten:

```bash
python -m robot --outputdir results tests/robot
```

Es ist natürlich auch möglich einzelne Test Suites zu starten:

```bash
python -m robot --outputdir results tests/robot/basket.robot
```

Nach dem Lauf liegen `report.html`, `log.html` und `output.xml` im Ordner `results/`. Diese Dateien bilden den Ausgangspunkt für die Auswertung im nächsten Abschnitt.

Zum Abschluss kann der Container entfernt werden:

```bash
docker compose -f webshop_app/docker-compose.yml down --remove-orphans
```

Der vollständige lokale Ablauf ist damit reproduziert. Als Nächstes lohnt sich der Blick auf die erzeugten Ergebnisse.

## Reports und Logs lesen

Robot Framework erzeugt standardmäßig drei zentrale Dateien:

- `report.html` zeigt den Gesamtstatus, Statistiken und Suite-Ergebnisse.
- `log.html` enthält den detaillierten Ausführungsbaum mit Keywords, Argumenten, Zeitstempeln und Fehlermeldungen.
- `output.xml` ist das maschinenlesbare Ergebnis für Nachbearbeitung und Integrationen.

Der Report beantwortet die Frage, was fehlgeschlagen ist. Das Log erklärt meist, warum es fehlgeschlagen ist. Es lohnt sich, `log.html` auch nach einem erfolgreichen ersten Lauf zu öffnen. Zu tief verschachtelte Keywords, unnötig geloggte Daten und schwer lesbare Abläufe werden dort früher sichtbar als im Quelltext.

`output.xml` kann mit dem Tool `rebot` weiterverarbeitet werden. Mehrere Läufe lassen sich kombinieren, Reports können neu erzeugt und fehlgeschlagene Tests gezielt erneut ausgeführt werden. Für CI ist die XML-Datei deshalb ebenso wichtig wie die HTML-Seiten.

Bei UI-Fehlern kommen Screenshots aus dem Teardown hinzu. Das Projekt speichert sie unterhalb des Ergebnisverzeichnisses. Screenshot, Keyword-Log und Zeitpunkt des Fehlers ergeben gemeinsam ein deutlich besseres Diagnosebild als eine einzelne Assertion-Meldung.

## Repository-Struktur

Die wichtigsten Verzeichnisse sind:

```text
.github/
└── workflows/     # Enthält den GitHub-Actions-Workflow

tests/
├── data/          # CSV- und Excel-Testdaten
├── resources/     # Keywords und Locators
├── robot/         # ausführbare Suites
└── variables/     # Umgebungswerte und Browserkonfiguration

scripts/
├── reporting/     # Aufbau der GitHub-Pages-Seite
└── test_support/  # Python-Helfer für Tests

webshop_app/       # Docker-Compose-Konfiguration für OWASP Juice Shop
docs/              # Architektur, Standards und Teststrategie
```

Die Struktur trennt fachliche Tests, technische Browserinteraktion, Testdaten und Umgebungskonfiguration. Dadurch wird sichtbar, warum eine Datei geändert wird. Eine neue Journey gehört in `tests/robot/`, ein geänderter Selektor in `tests/resources/` und eine neue Datenkombination in `tests/data/`.

Diese Ordnerstruktur bildet die Grundlage für die technische Architektur der Robot-Tests.

## Architektur und Aufbau von Robot-Tests verstehen

Ein Robot-Projekt besteht meist aus vier Ebenen:

- Eine `Suite` gruppiert zusammengehörige Testfälle.
- Ein `Testfall` beschreibt ein erwartetes Verhalten.
- Ein `Keyword` führt eine wiederverwendbare Aktion oder Prüfung aus.
- Ein `Locator` identifiziert ein Element im Browser.

Diese Ebenen werden im Repository auf unterschiedliche Dateitypen verteilt.

Eine `.robot`-Datei ist eine ausführbare Test-Suite. Sie wird mit dem `robot`-Befehl gestartet und importiert über `Resource` die Bausteine, die sie für den Testablauf benötigt. Da die Testfälle vor allem das erwartete Verhalten beschreiben, können sie auch gemeinsam mit dem Fachbereich entwickelt und geprüft werden.

Eine `.resource`-Datei dient als gemeinsamer Baukasten. Sie bündelt wiederverwendbare Keywords, Variablen und Locators. Die Suite ruft ein fachlich benanntes Keyword auf, während das Keyword bei Bedarf den passenden Locator und die technischen Browseraktionen verwendet. Dadurch bleiben die Testfälle lesbar und Browserdetails zentral verwaltet.

Locators sollten deshalb nicht direkt in fachlichen Suite-Dateien liegen. Ändert sich ein Attribut oder die CSS-Struktur des Webshops, sollte nur die zuständige Resource-Datei angepasst werden müssen.

Eine `.py`-Datei ergänzt Robot Framework bei klar abgegrenzten technischen Aufgaben. Sie kann beispielsweise CSV-Daten einlesen, Eingaben validieren und die aufbereiteten Werte als Robot-Variablen bereitstellen. Auch Hilfsskripte wie ein Readiness-Check für die Anwendung können in Python umgesetzt werden. Die `.robot`-Suite muss die interne Python-Implementierung dabei nicht kennen.

Der Zusammenhang lautet daher:

- `.robot` beschreibt Testfälle und deren Ablauf.
- `.resource` enthält wiederverwendbare Testschritte, Locators und technische Browserinteraktionen.
- `.py` übernimmt Aufgaben, für die Python besser geeignet ist, etwa komplexere Datenverarbeitung oder technische Hilfsfunktionen.

### Die vier wichtigsten Abschnitte einer Robot-Datei

Robot-Dateien sind tabellarisch aufgebaut. Zellen werden durch mindestens zwei Leerzeichen oder einen Tab getrennt. Für Einsteiger sind vier Abschnitte besonders wichtig.

#### `*** Settings ***`

Im Settings-Abschnitt werden Libraries, Resource-Dateien und Variable-Dateien importiert. Außerdem lassen sich unter anderem Dokumentation, Setup, Teardown und Test-Templates konfigurieren.

```robot
*** Settings ***
Library             DataDriver
Resource            ${CURDIR}/../resources/juice_shop.resource
Test Setup          Open Shop Homepage
Test Teardown       Handle Test Cleanup
Test Template       Search Row Should Match
```

`Library` lädt eine externe Testbibliothek. `Resource` bindet projektspezifische Keywords und Variablen ein. Mit `Test Setup` und `Test Teardown` werden Schritte festgelegt, die vor beziehungsweise nach jedem Test ausgeführt werden. Ein `Test Template` definiert ein Keyword, das für mehrere Datenzeilen verwendet wird.

#### `*** Variables ***`

Dieser Abschnitt enthält skalare Variablen, Listen und Dictionaries. Die Schreibweise zeigt, wie eine Variable verwendet wird:

- `${BASE_URL}` steht für einen einzelnen Wert.
- `@{ROWS}` steht für eine Liste.
- `&{VIEWPORT}` steht für ein Dictionary.

Variablen sollten Bedeutung transportieren. Nicht jedes Literal muss ausgelagert werden. Eine Base URL, ein Browser-Timeout oder ein fachlich relevanter Erwartungswert verdienen einen sprechenden Namen. Ein einmaliger, unkritischer Wert kann dagegen direkt im Keyword stehen.

#### `*** Test Cases ***`

Im Test-Cases-Abschnitt stehen die ausführbaren Tests. Ein guter Testname beschreibt das geprüfte Verhalten und möglichst auch das erwartete Ergebnis.

Der Testkörper sollte kurz genug bleiben, damit der Ablauf sowohl im Quelltext als auch im Robot-Report verständlich ist. Technische Details wie CSS-Selektoren, Browserinitialisierung oder komplexe Datenkonvertierungen gehören normalerweise nicht direkt in den Testfall.

#### `*** Keywords ***`

Im Keywords-Abschnitt werden wiederverwendbare Abläufe definiert. Keywords können Argumente annehmen, Werte zurückgeben, Kontrollstrukturen enthalten und weitere Keywords aufrufen.

Ein Keyword sollte eine klare Verantwortung besitzen. Namen wie `Do Login Things` verstecken die eigentliche Absicht. Namen wie `Submit Login Credentials` oder `Failed Login Should Be Visible` beschreiben dagegen konkret, was ausgeführt oder geprüft wird.

Robot Framework unterscheidet in diesem Projekt drei Arten von Keywords:

- `Built-in-Keywords` gehören zum Kern von Robot Framework und stehen ohne zusätzlichen Library-Import zur Verfügung. Beispiele sind `Convert To Integer`, `Wait Until Keyword Succeeds` und `Run Keyword And Ignore Error`.
- `Library-Keywords` werden von importierten Testbibliotheken bereitgestellt. Die Browser-Library liefert beispielsweise `Type Text`, `Press Keys` und `Close Browser`. `RPA.Excel.Files` ergänzt Keywords wie `Open Workbook` und `Read Worksheet`.
- `User-Keywords` werden im Projekt selbst definiert, meist in `.resource`-Dateien. Beispiele sind `Search For Product`, `Search Results Should Match` und `Open Shop Homepage`. Sie kombinieren technische Schritte zu einer projektspezifischen und fachlich verständlichen Aktion.

Ein Test wird dadurch schichtweise ausgeführt:

```text
Search Keywords From CSV
└── Search Results Should Match       # User-Keyword
    ├── Convert To Integer            # Built-in-Keyword
    ├── Search For Product            # User-Keyword
    │   ├── Type Text                 # Library-Keyword
    │   └── Press Keys                # Library-Keyword
    └── Catalog Should Show Exact Product Count
```

Diese Kette ist ein Kernprinzip von Robot Framework. Ein Testfall beschreibt das erwartete Verhalten. User-Keywords bilden die projektspezifische Sprache. Library-Keywords führen die technische Interaktion mit Browser, Dateien oder anderen Systemen aus.

Robot Framework selbst muss dabei weder den OWASP Juice Shop noch dessen HTML-Struktur kennen. Das Framework löst die Keyword-Aufrufe auf, steuert die Ausführung und erstellt anschließend Logs und Reports.

### Robot-Datei

Die Suite `search_method_2_Python_Reader.robot` importiert zwei unterschiedliche Bausteine. Die Resource-Datei stellt die Keywords für die UI-Prüfung bereit. Die Python-Datei liefert die aus der CSV-Datei gelesenen Daten als `${ROWS}`.

>>>>>>>> SCREENSHOT 1 statt unten stehenden text

```robot
*** Settings ***
Resource         ${CURDIR}/../resources/juice_shop.resource
Variables        ${CURDIR}/../../scripts/test_support/search_cases.py
Test Setup       Open Shop Homepage

*** Test Cases ***
Search Keywords From CSV
    FOR    ${row}    IN    @{ROWS}
        Search Results Should Match    ${row}[input]    ${row}[expectation]
    END
```

Der `Test Case` ruft das fachlich benannte User-Keyword `Search Results Should Match` auf. Die Suite kennt nur das Keyword und die Datenwerte. Sie enthält weder die Browser-Locators noch die Logik zum Einlesen der CSV-Datei. Dieses Keyword ist in einer `Resource`-Datei beschrieben.

### Resource-Datei

Die Datei `juice_shop.resource` enthält die technische Umsetzung des fachlich benannten Keywords `Search Results Should Match`. Sie zentralisiert wiederverwendbare Browseraktionen und Locators, damit die Suite keine CSS-Selektoren kennen muss.

```robot
*** Variables ***
${SEARCH_INPUT_LOCATOR}    css=app-mat-search-bar input:visible

*** Keywords ***
Search For Product
    [Arguments]    ${search_term}
    Ensure Search Input Is Ready
    Type Text    ${SEARCH_INPUT_LOCATOR}    ${search_term}
    Press Keys    ${SEARCH_INPUT_LOCATOR}    Enter
    Wait For Search State    ${search_term}

Search Results Should Match
    [Arguments]    ${search_term}    ${expected_result_count}
    ${expected_count}=    Convert To Integer    ${expected_result_count}
    Search For Product    ${search_term}
    IF    ${expected_count} == 0
        Wait Until Keyword Succeeds    10x    300ms    No Results Message Should Be Visible
    ELSE
        Wait Until Keyword Succeeds    10x    300ms    Catalog Should Show Exact Product Count    ${expected_count}
    END
```

`Search Results Should Match` verbindet alle drei Keyword-Arten. `Convert To Integer` und `Wait Until Keyword Succeeds` sind Built-in-Keywords. `Search For Product` und `Catalog Should Show Exact Product Count` sind User-Keywords. `Type Text` und `Press Keys` stammen aus der Browser-Library.


### Python-Datei

`search_cases.py` verwendet Pythons eingebaute `csv`-Bibliothek, um die Datei `search_keywords.csv` einzulesen und die Variable `ROWS` für Robot Framework bereitzustellen:

```python
import csv
from pathlib import Path

def _load_rows(data_path):
    with data_path.open(encoding="utf-8", newline="") as handle:
        return [
            {"input": row["Input"], "expectation": int(row["Expectation"])}
            for row in csv.DictReader(handle)
        ]

data_path = Path("tests/data/search_keywords.csv")
ROWS = _load_rows(data_path)
```

In der tatsächlichen Datei prüft der Reader zusätzlich die Spaltennamen und Werte. Das Beispiel zeigt die grundsätzliche Verbindung: Python liest und formt die Daten, Robot Framework iteriert über die Datensätze und das Resource-Keyword prüft das Verhalten des Webshops.

Die drei Dateitypen bilden damit eine klare Arbeitsteilung. Die Robot-Suite beschreibt, was geprüft wird. Die Resource-Datei definiert, wie die fachlichen Aktionen im Browser ausgeführt werden. Die Python-Datei bereitet die benötigten Testdaten vor.

## Setup und Teardown: Jeder Test startet definiert

Setup und Teardown verhindern, dass jeder Test denselben technischen Rahmen wiederholt. In den Suites gelten:

```robot
Test Setup       Open Shop Homepage
Test Teardown    Handle Test Cleanup
```

`Open Shop Homepage` startet einen Browser, legt einen neuen Context an, öffnet die Seite, schließt Startdialoge und wartet auf den Katalog. `Handle Test Cleanup` erstellt bei einem Fehler einen Screenshot und beendet die Browser-Session.

```robot
Handle Test Cleanup
    Take Failure Screenshot
    Close Browser Session
```

Der Teardown wird auch nach einem fehlgeschlagenen Test ausgeführt. Das ist wichtig, weil gerade Fehlerfälle Browserprozesse, Dateien oder Testdaten hinterlassen können. Cleanup darf deshalb möglichst wenig neue Fehler erzeugen. Das Projekt verwendet beim Schließen `Run Keyword And Ignore Error`, damit ein bereits geschlossener Browser das ursprüngliche Testergebnis nicht überdeckt.

Optional kann die Suite Videos aufzeichnen. Dazu werden beim Start Variablen überschrieben:

```bash
python -m robot \
  --outputdir results \
  --variable RECORD_VIDEO:True \
  --variable HEADLESS:False \
  tests/robot
```

Videos sind hilfreich bei schwer reproduzierbaren UI-Problemen, erhöhen aber Laufzeit und Artefaktgröße. Für jeden normalen Lauf sind Screenshots meist ausreichend.

## Datengetriebene Tests mit Robot Framework

Datengetriebene Tests trennen Testlogik und Eingabekombinationen. Statt denselben Suchablauf für `apple`, `banana`, ein Leerzeichen und `mango` zu kopieren, wird ein Keyword mit mehreren Datensätzen ausgeführt.

Das Repository demonstriert drei Wege, die Daten bereitzustellen. Die fachliche Assertion bleibt gleich.

- Methode 1: Robot Framework DataDriver
- Methode 2: Python-Reader mit Python-Hilfsdatei
- Methode 3: RPA.Excel.Files

### Methode 1: Robot Framework DataDriver

`search_method_1_DataDriver.robot` verwendet die DataDriver-Library. Die CSV-Spalten werden an ein Test-Template übergeben. Aus jeder Datenzeile entsteht ein eigener Robot-Test.

Diese Methode eignet sich, wenn die Datei bereits der von DataDriver erwarteten Struktur entspricht und die Werte direkt an ein Robot-Test-Template übergeben werden können. Sie vermeidet einen separaten Python-Reader, aber der CSV-Header muss das spezielle DataDriver-Format verwenden, das zur Template-Signatur passt. DataDriver liest die Datei während Robot die Suite vorbereitet und übergibt die Spaltenwerte an das Template-Keyword.

```robot
*** Settings ***
Library         DataDriver
...                 file=${CURDIR}/../data/search_keywords_datadriver.csv
Test Template   Search Row Should Match

*** Test Cases ***
Search for "${keyword}" should return ${amount_of_results} results
    keyword    results
```

Die gewählte Lösung liefert außerdem die beste Granularität im Report. Im mitgelieferten Lauf wurden aus sechs CSV-Zeilen sechs eigenständige Tests. Jeder Test erhält durch Setup und Teardown eine neue Browser-Session. Das verbessert Isolation, kostet aber mehr Laufzeit.

### Methode 2: Python-Reader für CSV

Diese Methode eignet sich, wenn vollständige Kontrolle darüber benötigt wird, wie CSV-Daten gelesen werden, bevor Robot sie erhält. `csv.DictReader` ordnet jede Zeile ihren Spaltenüberschriften zu. Der Python-Helfer kann erforderliche Spalten prüfen, Werte in den passenden Typ umwandeln, Eingaben normalisieren oder eine klare Fehlermeldung für ungültige Daten ausgeben.

`search_method_2_Python_Reader.robot` importiert `search_cases.py` als Variable-Datei:

```robot
Variables    ${CURDIR}/../../scripts/test_support/search_cases.py
```

Das Python-Skript liest und verarbeitet die CSV-Datei:

```python
with data_path.open(encoding="utf-8", newline="") as handle:
    reader = csv.DictReader(handle)
    if reader.fieldnames != list(EXPECTED_COLUMNS):
        raise ValueError("Unexpected CSV columns")

    rows = [
        {
            "input": row["Input"] or "",
            "expectation": int(row["Expectation"] or ""),
        }
        for row in reader
    ]
```

Robot iteriert anschließend über die Liste:

```robot
FOR    ${row}    IN    @{ROWS}
    Search Results Should Match    ${row}[input]    ${row}[expectation]
END
```

Diese Variante bietet die meiste Kontrolle über Validierung und Normalisierung. Der Nachteil ist zusätzlicher Python-Code. Außerdem erscheint die gesamte Schleife als ein Robot-Test. Schlägt eine Zeile fehl, stoppt die Schleife in der aktuellen Implementierung beim ersten Fehler.

### Methode 3: `RPA.Excel.Files`

`search_method_3_RPA_Excel_Files.robot` liest eine Excel-Arbeitsmappe direkt.

Diese Methode eignet sich, wenn die Quelldaten eine Excel-Arbeitsmappe sind. Excel ist sinnvoll, wenn Fachbereiche Daten bereits in Arbeitsmappen pflegen, mehrere Tabellenblätter benötigt werden oder CSV nicht ausreicht. Für wenige einfache Werte ist Excel meist unnötig schwergewichtig.

Die `RPA.Excel.Files`-Bibliothek kann eine Arbeitsmappe öffnen, ein Arbeitsblatt auswählen und Zeilen anhand der Überschriftenzeile als Dictionaries zurückgeben. Sie ist nützlich, wenn ein Team die Testeingaben bereits in Excel pflegt oder mehrere Arbeitsblätter benötigt. Bei einfachen Daten ist sie jedoch komplexer als eine CSV-Datei.

```robot
*** Keywords ***
Load Search Rows From Excel
    Open Workbook    ${SEARCH_EXCEL_FILE}
    ${rows}=    Read Worksheet    name=${SEARCH_WORKSHEET_NAME}    header=${TRUE}
    Close Workbook
    RETURN    ${rows}
```

### Welche Methode passt wann?

| Methode | Stärke | Schwäche | Geeignet für |
|---|---|---|---|
| DataDriver | einfach einsetzbar | spezielles CSV-Format | Regressionstabellen und gute Fehlerlokalisierung |
| Python-Reader | maximale Validierung und Transformation | zusätzlicher Code, ein aggregierter Test | unregelmäßige oder streng zu prüfende Daten |
| RPA.Excel.Files | direkte Arbeit mit Excel | zusätzliche Abhängigkeit, aggregierter Report | fachlich gepflegte Arbeitsmappen |

Die Entscheidung sollte nicht allein vom bevorzugten Dateiformat abhängen. Wichtig sind auch Fehlerdiagnose, Testisolation, Laufzeit und die Frage, wer die Daten pflegt.

## Tests in GitHub Actions ausführen

Robot Framework passt gut in CI, weil ein Testlauf über einen einzelnen Befehl gestartet wird und standardisierte HTML- sowie XML-Ergebnisse erzeugt. Der vorgesehene Ablauf des Projekts ist im Workflow `.github/workflows/ui-tests.yml` beschrieben. Bei Pull Requests und Pushes auf `main` führt der Workflow Folgendes aus:

1. Repository auschecken und Python einrichten.
2. Projektabhängigkeiten installieren.
3. Browser-Library initialisieren.
4. Juice Shop mit Docker Compose starten.
5. Mit `wait_for_url.py` auf die Bereitschaft des Webshops warten.
6. Robot-Suites ausführen.
7. `results/` als Artefakt hochladen.
8. Die Robot-Ergebnisdateien für GitHub Pages kopieren.
9. Container stoppen.

Wichtig ist die Ähnlichkeit zwischen lokalem und CI-Ablauf. Je weniger Sonderlogik die Pipeline enthält, desto leichter lassen sich Fehler reproduzieren. Die Anwendung wird pro Lauf neu gestartet, wodurch jeder Build einen bekannten Ausgangszustand erhält.

Das Skript `scripts/reporting/build_pages_site.py` kopiert `report.html`, `log.html`, `output.xml` und weitere Ergebnisdateien in ein statisches Verzeichnis. Eine kleine Startseite verlinkt anschließend auf die nativen Robot-Berichte. GitHub Pages ist damit nur die Veröffentlichungsfläche, nicht das Testsystem selbst.

## Stärken und Grenzen von Robot Framework

Die größte Stärke ist nicht eine vermeintlich natürliche Sprache, sondern die kontrollierte Abstraktion. Fachliche Tests können kurz bleiben, während technische Details in Libraries und Resources liegen. Weitere Vorteile sind plattformunabhängige Ausführung, erweiterbare Python-Schnittstellen, Daten-Templates und sofort verfügbare Reports.

Die Lesbarkeit kann allerdings kippen. Zu große Keywords verstecken wichtige Testschritte. Zu viele kleine Keywords erzeugen einen tiefen Log-Baum. Ressourcen mit langen Importketten erschweren die Suche nach der tatsächlichen Implementierung. Gute Robot-Suites brauchen deshalb dieselbe Architekturdisziplin wie normaler Anwendungscode.

Auch die Aussage, Robot Framework erfordere keine Programmierkenntnisse, gilt nur für einfache Fälle. Für robuste UI-Tests sind Kenntnisse in HTML, CSS, Browserzuständen, Datenmodellierung, Python und CI sehr nützlich. Robot Framework senkt die Einstiegshürde, ersetzt diese Kompetenzen aber nicht.

Für sehr algorithmische Logik ist Python oft die bessere Ebene. Robot sollte die fachliche Orchestrierung und gut lesbare Assertions behalten. Komplexe Parser, Datenkonvertierungen oder technische Integrationen gehören in kleine, getestete Libraries oder Hilfsskripte.

## Nächste Schritte

Das Repository bietet mehrere Erweiterungspunkte zum Lernen:

- Testdaten ändern.
- Einen Test zum Entfernen von Artikeln aus dem Warenkorb schreiben.
- Tests mit Tags versehen und Smoke- sowie Regression-Läufe trennen.
- Checkout-Tests ergänzen, ohne ein einziges übergroßes `Complete Checkout`-Keyword zu bauen.

Jede Erweiterung sollte dieselbe Grundregel beibehalten: Testfälle beschreiben Verhalten, Resources kapseln Browserdetails, Daten bleiben außerhalb des Ablaufs und die Pipeline führt möglichst dieselben Befehle aus wie die lokale Entwicklung.

## Weiterführende Quellen
Die folgenden Quellen vertiefen die beschriebenen Konzepte und Konventionen.

- [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [Robot Framework Browser Library](https://docs.robotframework.org/docs/different_libraries/browser)
- [Robot Framework Style Guide](https://docs.robotframework.org/docs/style_guide)
