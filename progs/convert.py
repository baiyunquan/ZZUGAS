#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Convert all GB2312 encoded files in the directory tree to UTF-8 (without BOM)
"""

import os
import sys
from pathlib import Path


def detect_encoding(file_path):
    """
    Detect if a file is GB2312 encoded.
    Returns 'gb2312' if detected, None otherwise.
    """
    try:
        with open(file_path, 'rb') as f:
            raw_data = f.read()
        
        # Try to decode as GB2312
        raw_data.decode('gb2312')
        return 'gb2312'
    except (UnicodeDecodeError, Exception):
        return None


def is_text_file(file_path):
    """
    Simple check to see if a file is likely a text file.
    """
    # Check by extension
    text_extensions = {
        '.txt', '.py', '.c', '.h', '.s', '.S', '.asm', '.as', '.lst',
        '.i', '.l', '.C', '.md', '.sh', '.ps1', '.bat', '.cmd'
    }
    
    suffix = Path(file_path).suffix.lower()
    if suffix in text_extensions:
        return True
    
    # Files without extension might be text too, try to read first few bytes
    try:
        with open(file_path, 'rb') as f:
            chunk = f.read(512)
        
        # Check if it's mostly ASCII/UTF-8
        try:
            chunk.decode('utf-8')
            return True
        except UnicodeDecodeError:
            try:
                chunk.decode('gb2312')
                return True
            except UnicodeDecodeError:
                return False
    except Exception:
        return False


def convert_file(file_path):
    """
    Convert a GB2312 file to UTF-8 (without BOM).
    Returns True if converted, False otherwise.
    """
    try:
        # Read file with GB2312 encoding
        with open(file_path, 'r', encoding='gb2312') as f:
            content = f.read()
        
        # Write file with UTF-8 encoding (no BOM)
        with open(file_path, 'w', encoding='utf-8-sig', newline='') as f:
            f.write(content)
        
        # Remove BOM if it was added
        with open(file_path, 'rb') as f:
            raw = f.read()
        
        # Check and remove UTF-8 BOM (EF BB BF)
        if raw.startswith(b'\xef\xbb\xbf'):
            with open(file_path, 'wb') as f:
                f.write(raw[3:])
        
        return True
    except Exception as e:
        print(f"Error converting {file_path}: {e}")
        return False


def main():
    """Main function to process all files in the directory tree."""
    # Get the directory of the script
    script_dir = Path(__file__).parent
    
    print(f"Processing directory: {script_dir}")
    print("=" * 60)
    
    converted_count = 0
    checked_count = 0
    
    # Walk through all files in the directory tree
    for root, dirs, files in os.walk(script_dir):
        for file in files:
            file_path = Path(root) / file
            
            # Skip hidden files and certain directories
            if file.startswith('.'):
                continue
            
            try:
                # Check if it's a text file
                if not is_text_file(file_path):
                    continue
                
                checked_count += 1
                
                # Detect encoding
                encoding = detect_encoding(file_path)
                if encoding == 'gb2312':
                    print(f"Converting: {file_path.relative_to(script_dir)}")
                    if convert_file(file_path):
                        converted_count += 1
                        print(f"  ✓ Converted to UTF-8")
                    else:
                        print(f"  ✗ Failed to convert")
            
            except Exception as e:
                print(f"Error processing {file_path}: {e}")
    
    print("=" * 60)
    print(f"Processed {checked_count} text files")
    print(f"Converted {converted_count} files from GB2312 to UTF-8")


if __name__ == '__main__':
    main()
