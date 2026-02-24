import 'dart:io';

void main() {
  var file = File('lib/screens/gallery_screen.dart');
  var content = file.readAsStringSync();
  
  // replace const before widgets/types that now use context.sbTheme
  content = content.replaceAllMapped(
    RegExp(r'const\s+([A-Z]\w*\((?:[^)(]+|\([^)(]*\))*\bcontext\.sbTheme\b.*?\))', multiLine: true, dotAll: true),
    (match) => match.group(1)!
  );
  
  file.writeAsStringSync(content);
}
