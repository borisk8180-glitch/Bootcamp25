#!/usr/bin/env python3
"""
Cracker skeleton to get you started.
- Fill in brute_force_pin()
- Fill in crack_level2() and crack_level3() using the provided wordlist and records.
"""
import hashlib, json, itertools, time

def brute_force_pin(target_hash):
    for i in range(10000):
        pin = f"{i:04d}"
        if hashlib.sha256(pin.encode()).hexdigest() == target_hash:
            return pin
    return None

def sha256_salted(salt, pwd):
    return hashlib.sha256((salt + pwd).encode()).hexdigest()

def pbkdf2_sha256(pwd, salt, iters=100_000, dklen=32):
    return hashlib.pbkdf2_hmac("sha256", pwd.encode(), salt.encode(), iters, dklen).hex()

def crack_level2(records_path, wordlist_path):
    results = {}
    with open(records_path, "r", encoding="utf-8") as recs, open(wordlist_path, "r", encoding="utf-8") as wl:
        words = [w.strip() for w in wl if w.strip()]
        recs = [json.loads(line) for line in recs]
        for rec in recs:
            user, salt, target = rec["user"], rec["salt"], rec["hash"]
            for w in words:
                if sha256_salted(salt, w) == target:
                    results[user] = w
                    break
    return results

def crack_level3(records_path, wordlist_path):
    results = {}
    with open(records_path, "r", encoding="utf-8") as recs, open(wordlist_path, "r", encoding="utf-8") as wl:
        words = [w.strip() for w in wl if w.strip()]
        recs = [json.loads(line) for line in recs]
        for rec in recs:
            user, salt, iters, target = rec["user"], rec["salt"], rec["iters"], rec["hash"]
            for w in words:
                if pbkdf2_sha256(w, salt, iters) == target:
                    results[user] = w
                    break
    return results

if __name__ == "__main__":
    PIN_HASH = "aea7c84e71ff79d7e04d992894ce2ac89edeebdd5a7808ca18920bd2a3f84810"
    pin = brute_force_pin(PIN_HASH)
    print("Recovered PIN:", pin)

    l2 = crack_level2("level2.jsonl", "wordlist.txt")
    print("Level 2:", l2)

    l3 = crack_level3("level3.jsonl", "wordlist.txt")
    print("Level 3:", l3)
