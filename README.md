# VICTORIOUSNUMBER

**Générateur de noms de code pour iOS.**

VICTORIOUSNUMBER est une application SwiftUI moderne conçue pour générer des noms de code uniques en combinant des adjectifs et des noms.

## Fonctionnalités

*   **Génération de Noms de Code :** Crée des combinaisons aléatoires (format `ADJECTIFNOM` en majuscules).
*   **Interface Moderne :** Utilise les derniers composants SwiftUI (iOS 17+) comme `NavigationStack` et `ContentUnavailableView`.
*   **Architecture Robuste :** Architecture MVVM avec chargement de données asynchrone (`async/await`) pour une fluidité optimale.
*   **Gestion des Erreurs :** Interface utilisateur résiliente avec options de réessai en cas d'échec de chargement des données.
*   **Presse-papiers :** Copiez facilement les noms générés en tapant sur l'icône de copie.

## Prérequis

*   Xcode 15.0 ou supérieur.
*   iOS 26.0 ou supérieur.

## Installation

1.  Clonez ce dépôt.
2.  Ouvrez `VICTORIOUSNUMBER.xcodeproj` dans Xcode.
3.  Assurez-vous que les fichiers de données `adjectives.json` et `nouns.json` sont présents dans le dossier `Models`.
4.  Compilez et lancez sur votre simulateur ou appareil.

## Architecture

L'application suit le modèle **MVVM** (Model-View-ViewModel) :

*   **Models :** Fichiers JSON locaux contenant les listes de mots.
*   **ViewModels :** `CodeNameViewModel` gère la logique métier, le chargement asynchrone et l'état de l'interface (chargement, erreur, succès).
*   **Views :** `LaunchView` et `CodeNameListView` pour l'interface utilisateur.

## Auteur

Développé avec ❤️ et SwiftUI.
