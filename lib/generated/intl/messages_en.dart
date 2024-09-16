// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "appTitle": MessageLookupByLibrary.simpleMessage("My Portfolio"),
        "contact": MessageLookupByLibrary.simpleMessage("Contact"),
        "contactInfo": MessageLookupByLibrary.simpleMessage(
            "You can reach me via email at example@example.com."),
        "description": MessageLookupByLibrary.simpleMessage(
            "Here you can find my latest projects and information about me."),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "failureWeather":
            MessageLookupByLibrary.simpleMessage("Error getting weather data."),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "languageSwitch":
            MessageLookupByLibrary.simpleMessage("Switch Language"),
        "noResults": MessageLookupByLibrary.simpleMessage("No results found."),
        "projectDescription": MessageLookupByLibrary.simpleMessage(
            "Description of the project goes here."),
        "projectTitle": MessageLookupByLibrary.simpleMessage("Project Title"),
        "projects": MessageLookupByLibrary.simpleMessage("Projects"),
        "search": MessageLookupByLibrary.simpleMessage("Search..."),
        "shortEnglish": MessageLookupByLibrary.simpleMessage("EN"),
        "shortSpanish": MessageLookupByLibrary.simpleMessage("ES"),
        "spanish": MessageLookupByLibrary.simpleMessage("Spanish"),
        "weatherNoData":
            MessageLookupByLibrary.simpleMessage("No weather data available."),
        "welcomeMessage":
            MessageLookupByLibrary.simpleMessage("Welcome to my portfolio!")
      };
}
