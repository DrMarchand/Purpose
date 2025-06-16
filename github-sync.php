<?php
// CONFIGURATION
$token = getenv('GITHUB_TOKEN'); // store securely in environment
$repo = "DrMarchand/Purpose";
$file = "sync-protocol.json";
$branch = "main";

// BUILD URL
$url = "https://api.github.com/repos/{$repo}/contents/{$file}?ref={$branch}";

// INITIALIZE CURL
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    "Authorization: token {$token}",
    "User-Agent: Kyle-Sync-Client",
    "Accept: application/vnd.github.v3.raw"
]);

// FETCH FILE
$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

// HANDLE RESPONSE
if ($httpCode === 200) {
    $json = json_decode($response, true);
    echo "✅ Fetched content:\n";
    print_r($json);
    
    // Optional: save to file
    file_put_contents("local-sync-protocol.json", json_encode($json, JSON_PRETTY_PRINT));
} else {
    echo "❌ Failed to fetch file. HTTP Code: {$httpCode}\n";
    echo "Response: {$response}";
}
?>
