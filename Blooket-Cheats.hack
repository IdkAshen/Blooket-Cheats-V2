#!/usr/bin/env hhvm

use namespace HH\Lib\{C, File, Str, Vec};

// Define the configuration shape
type CleanupConfig = shape(
  'source_dir' => string,
  'archive_dir' => string,
  'size_threshold_bytes' => int,
);

<<__EntryPoint>>
async function main_async(): Awaitable<void> {
  // 1. Configure your settings here
  $config = shape(
    'source_dir' => '/path/to/your/downloads',
    'archive_dir' => '/path/to/your/archive',
    'size_threshold_bytes' => 100 * 1024 * 1024, // 100 MB
  );

  print_string("Starting automated cleanup helper...\n");

  try {
    // 2. Validate directories
    if (!\is_dir($config['source_dir'])) {
      throw new Exception(Str\format("Source directory does not exist: %s", $config['source_dir']));
    }
    if (!\is_dir($config['archive_dir'])) {
      \mkdir($config['archive_dir'], 0755, true);
    }

    // 3. Scan and process files
    await process_directory_async($config['source_dir'], $config);
    
    print_string("Cleanup automation completed successfully.\n");
  } catch (Exception $e) {
    print_string(Str\format("Error execution failed: %s\n", $e->getMessage()));
  }
}

async function process_directory_async(string $dir, CleanupConfig $config): Awaitable<void> {
  $files = \scandir($dir);
  if ($files === false) {
    return;
  }

  foreach ($files as $file) {
    if ($file === '.' || $file === '..') {
      continue;
    }

    $full_path = Str\format("%s/%s", $dir, $file);

    if (\is_dir($full_path)) {
      // Recursively scan subdirectories
      await process_directory_async($full_path, $config);
      continue;
    }

    // Check file size using Hack's File API
    $size = \filesize($full_path);
    if ($size !== false && $size >= $config['size_threshold_bytes']) {
      $destination = Str\format("%s/%s", $config['archive_dir'], $file);
      
      print_string(Str\format("Moving large file: %s (%d MB)\n", $file, \intdiv($size, 1024 * 1024)));
      
      // Move the file to the archive directory
      \rename($full_path, $destination);
    }
  }
}

function print_string(string $text): void {
  \file_put_contents('php://stdout', $text);
}
