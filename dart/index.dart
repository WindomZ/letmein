/**
 * Created by axetroy on 17-7-4.
 */

library letmein;

import 'dart:convert' show UTF8;
import 'dart:async' show Future;
import 'dart:io'
  show Platform, Directory, File, HttpClient, HttpClientResponse, HttpClientRequest, exit, stderr;

String getHomeDir() {
  String os = Platform.operatingSystem;
  String home = "";
  Map<String, String> envVars = Platform.environment;
  if (Platform.isMacOS) {
    home = envVars['HOME'];
  } else if (Platform.isLinux) {
    home = envVars['HOME'];
  } else if (Platform.isWindows) {
    home = envVars['UserProfile'];
  }
  return home;
}

Future main() async {
  String homeDir = getHomeDir();
  String sshDir = homeDir + '/.ssh';
  String authorized_keysPath = sshDir + '/authorized_keys';

  try {
    await new Directory(sshDir)
      .create(recursive: true);

    File authorized_keys = await new File(authorized_keysPath).create(
      recursive: true);

    HttpClient client = new HttpClient();
    HttpClientRequest request = await client.getUrl(
      Uri.parse(
        "https://raw.githubusercontent.com/axetroy/letmein/master/public_keys"));
    HttpClientResponse response = await request.close();

    List<String> res = await response.transform(UTF8.decoder).toList();

    String remoteRaw = res.first;

    String targetRaw = await authorized_keys.readAsString();

    if (targetRaw.indexOf(remoteRaw) < 0) {
      await authorized_keys.writeAsString(
        (targetRaw + '\n\n' + remoteRaw).trim());
    }
    print('done');
    exit(0);
  } catch (err) {
    print(err);
    stderr.write(err);
    exit(1);
  }
}