# Repository Proof of Authorship and Creation  

*(Copyright and proof of origin for the repository.)*  

## 1. Repository Information  

- **Repository name:** PictureMetadata  
- **Repository URL:** <https://github.com/ncoldwave/PictureMetadataEditor>  
- **Owner / Author:** Róbert Kovács  
- **Creation date:** 2025-10-19 21:53:54 +02:00  
- **Repository status:** Private (timestamped commits)  
- **Purpose:** User-facing editor for reading, writing, and verifying embedded metadata in digital images across platforms with a different business plan that sets it apart from similar projects.

## 2. Proof of Authorship  

This repository and its commits serve as timestamped digital records proving authorship, creation date, and development history of the materials contained herein.  
Each commit is cryptographically verifiable through SHA-1 and SHA-256 hashes within the Git version control system.  

No source code or confidential content is publicly disclosed; however, logs and hash identifiers are available for verification upon request by authorized authorities or intellectual property offices.  

## 3. Get First GitHub commit date

```bash
git log --reverse --format="format:%aI" --all | head -n 1
```

[SOURCE](https://webapps.stackexchange.com/questions/43742/how-do-i-find-the-date-of-the-first-commit-in-a-github-repository)

## 4. Verification Method  

### a) **Git Commit Log Export**

A summarized commit history has been exported to a verification file (`repo_log.txt`) using the following format:  

```bash
git log --pretty=format:"%h | %an | %ae | %ad | %s" --date=iso > repo_log.txt
```

### b) **Timestamp and Hash Verification**

The repository and exported log are timestamped using the WIPO Proof and eIDAS-compliant digital certification.  
This ensures immutable proof of creation independent of national registration processes.

### c) **Verification Evidence**  

| File | Hash (SHA-256) | Timestamp source |
|------|----------------|------------------|
| repo_log.txt | [insert hash here] | WIPO Proof / eIDAS |
| LICENSE_DEV.zip | [insert hash here] | WIPO Proof / eIDAS |

#### Creating SHA-256 evidence

**Linux:**

```bash
sha256sum repo_log.txt
```

or for multiple files:

```bash
sha256sum repo_log.txt LICENSE_DEV.zip WIPO_Proof_Certificate.pdf > LICENSE_DEV_Hash_List.txt
```

**Windows:**

```bash
Get-FileHash -Algorithm SHA256 .\repo_log.txt
```

**macOS:**

```bash
sha256sum repo_log.txt
```

#### Hash check for proof

```bash
echo "67574ee0039eaf4043a237e7c4b0eb432ca07ebf9c7b2dd0667e83bc3900b2cf kali-linux-2019.2-amd64.iso" | sha256sum -c
```

In case you have the sha256sum file, you can directly use it:

```bash
sha256sum -c "kali-linux-2019.2-amd64.iso.txt.sha256sum"
```

Explanation:

In the above example, you have

```bash
echo "<known SHA 256 sum of the file> <name of the file>" | sha256sum -c
```

sha256sum -c option can either read the SHA256 sum from a sha256sum file or from STDIN. In case you don't have the sha256sum file, then using the echo command you can provide the same details contained in a sha256sum file.

In case you have the sha256sum file, you can directly use it:

```bash
sha256sum -c "<sha256sum file name>"
```

Note:

Alternatively, you can use shasum -a 256 instead of sha256sum where -a specifies the algorithm to be used.

[SOURCE](https://superuser.com/questions/1312740/how-to-take-sha256sum-of-file-and-compare-to-check-in-one-line)

## 5. Legal Statement  

> This repository and its contents are the exclusive intellectual property of **Róbert Kovács**.  
> Any registration, reproduction, or filing by a third party without the author's prior written consent shall be considered an infringement.  
> The materials are protected under international copyright conventions and the Paris Convention for the Protection of Industrial Property (1883).  
> Proof of authorship and creation date is established through timestamped commits and certified logs in this repository.

## 6. Contact Information  

**Author / Rights Holder:**  
Róbert Kovács  
📧 <robbi.mobile@gmail.com>  
📧 <legal@ncoldwave.com>  
📧 <legal@aeternvalens.com>  
📍 Velence, Hungary  

*This file serves as an official proof-of-authorship record for intellectual property verification purposes.  
No source code or confidential content is disclosed within this document.*
