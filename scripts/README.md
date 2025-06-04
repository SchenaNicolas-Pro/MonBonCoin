# Data Cleaning Script for DATAtourisme

This folder contains a lightweight Python script used to preprocess open data from [DATAtourisme](https://info.datatourisme.fr/).

The script extracts only the relevant fields for mobile usage, normalizes them into consistent formats, and reduces the overall payload size — making the dataset easier to integrate into the MonBonCoin app.

---

## 📁 Files

- `clean_datatourisme.py` — the script that transforms the original dataset into a simplified JSON format
- `data_before.json` — a sample raw data file (extracted from DATAtourisme)
- `data_after.json` — the cleaned output produced by the script

---

## ▶️ How to Use

1. Place `clean_datatourisme.py` in the same folder as your original `.json` file from DATAtourisme.  
2. Open the script and update the input/output filenames if needed:  

   ```python
   # Line 21  
   with open('data_before.json', 'r') as json_file:  
  
   # Line 209  
   with open('data_after.json', 'w', encoding='utf-8') as new_json_file:  

Replace 'data_before.json' and 'data_after.json' with your desired input/output filenames if needed.
  
3. Save the script.
  
4. Open Terminal, navigate to the folder, and run:  
```bash
python3 clean_datatourisme.py
```
  
## 🧹 What the Script Does

- Extracts relevant fields (label, description, location, price, opening hours, contact, images, etc.)  
- Handles inconsistent field structures (list vs. object)  
- Normalizes string fields into lists for consistent downstream processing  
- Outputs a cleaned, lighter dataset suitable for Firebase ingestion and CoreData integration  

## 📌 Note

This script is intentionally minimal and focused on the needs of this specific app.  
It's not a general-purpose cleaner for DATAtourisme data, but can serve as a base for further customization.
