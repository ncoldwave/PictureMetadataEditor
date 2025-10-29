# Repository Proof of Authorship and Creation

*(Copyright and proof of origin for the repository.)*  

## 1. Repository Information  

- **Project name:** PictureMetadataEditor™
- **Repository name:** PictureMetadata  
- **Code name:** AV_POME
- **Repository URL:** <https://github.com/ncoldwave/PictureMetadataEditor>  
- **Project domain:** [picturemetadataeditor.com](https://picturemetadataeditor.com) *Registered and reserved for the project use; site under development*
- **Owner / Author:** Róbert Kovács  
- **Creation date:** 2025-10-19 21:53:54 +02:00  
- **Repository status:** Private (timestamped commits)  
- **Proof Archive:** TODO
- **Last proofing and submission:** <!-- TODO: 2025-10-20 -->

## Proof of Authorship  

This repository and its commits serve as timestamped digital records proving authorship, creation date, and development history of the materials contained herein.  
Each commit is cryptographically verifiable through SHA-1 and SHA-256 hashes within the Git version control system.  

No source code or confidential content is publicly disclosed; however, logs and hash identifiers are available for verification upon request by authorized authorities or intellectual property offices.  

## Proofed Repository Purpose

<!-- TODO -->

## Origin Reference (if needed)

First documents and concept drafts originated in NexorAA-VisRae repository (proof chain 2025-02-18).

### Verification Evidence

For Repositories:

| ID      | File                                   | Version          | Source Commit ID | SHA-256 (short) | RFC 3161 | RFC Date | HIPO Proof ID | HIPO Proof Date | Notes                                   |
|---------|----------------------------------------|------------------|---------------|-----------------|----------|----------|---------------|-----------------|-----------------------------------------|
| PR-0001 | repo_log.txt                           | 2025.0.0.1-Proof | N/A           | N/A             | N/A      | N/A      | N/A           | N/A             | Repository log history                  |
| PR-0001 | repo_log_full.txt                      | 2025.0.0.1-Proof | N/A           | N/A             | N/A      | N/A      | N/A           | N/A             | Repository log history with full hashes |
| PR-0002 | SHA256SUMS.txt                         | 2025.0.0.1-Proof | N/A           | N/A             | N/A      | N/A      | N/A           | N/A             | Repository hash log with full hashes    |
| PR-0003 | repository\_proof.json                 | 2025.0.0.1-Proof | N/A           | N/A             | N/A      | N/A      | N/A           | N/A             | Proofs of all files and the repo        |
| PR-0004 | [Repository]-[datetime]-[commitID].zip | 2025.0.0.1-Proof | N/A           | N/A             | N/A      | N/A      | N/A           | N/A             | Compressed Repository                   |

<div class="page-break"></div>

## Storage & Archival

Proof package (ZIP + SHA256SUMS + timestamp) stored in:

- **Proof Repository:** ProofArchive (private)
- **Proof Repository URL:** <https://github.com/ncoldwave/ProofArchive>
- **Audit ID:** <!-- ProofArchive-Master-[DATETIME].zip -->

### Sample content of the ProofArchive-Master content - Confidential appendix

```tree
ProofArchive-Master-[DATETIME].zip                    --- Master archive containing all proof materials
├── Repositories-[DATE]/                                  --- Collection of project repositories
│   ├── [RepositoryName]-[DATETIME]-[COMMIT_ID].zip       --- Compressed archive of a specific repository
│   │   ├── [RepositoryName]-[DATETIME]-[CommitID].zip    --- Source code and documentation of the project
│   │   │   ├── REPOSITORY_PROOF_OF_AUTHORSHIP.md         --- Authorship declaration and proof for the repository
│   │   │   ├── README.md                                 --- Project overview with main requirements
│   │   │   └── ...                                       --- Other project files and folders
│   │   └── metadata/                                     --- Metadata and timestamped verification files
│   │       ├── [RepositoryName]-[DATETIME]-[CommitID].tsq        --- Timestamp request for the repository archive
│   │       ├── [RepositoryName]-[DATETIME]-[CommitID].tsr        --- Timestamp response confirming authenticity
│   │       ├── [RepositoryName]-[DATETIME]-repo_log_full.txt     --- Full commit log with SHA hashes
│   │       ├── [RepositoryName]-[DATETIME]-repo_log_full.tsq     --- Timestamp request for log
│   │       ├── [RepositoryName]-[DATETIME]-repo_log_full.tsr     --- Timestamp response for log
│   │       ├── [RepositoryName]-[DATETIME]-repo_log.txt          --- Commit log with shortened SHA codes
│   │       ├── [RepositoryName]-[DATETIME]-repo_log.tsq          --- Timestamp request for log
│   │       ├── [RepositoryName]-[DATETIME]-repo_log.tsr          --- Timestamp response for log
│   │       ├── [RepositoryName]-[DATETIME]-SHA256SUMS.txt        --- SHA256 checksums of all repository files
│   │       ├── [RepositoryName]-[DATETIME]-proof.json            --- JSON file containing digital proof metadata
│   │       ├── [RepositoryName]-[DATETIME]-proof.sig             --- Digital signature for the proof.json file
│   │       ├── [RepositoryName]-[DATETIME]-SHA256SUMS.tsq        --- Timestamp request for checksum file
│   │       └── [RepositoryName]-[DATETIME]-SHA256SUMS.tsr        --- Timestamp response for checksum file
│   ├── ...                                              --- Additional repositories (if any)
|   └── master-metadata/                                      --- master zip file metadata
|       └── ...                                                   --- same content for master zip like "metadata/"
├── help/                                            --- Documentation and troubleshooting guides
│   ├── miscellaneous/                                   --- Technical notes and how-tos
│   │   ├── gpg_howto.md                                 --- Guide for using GPG for signing and verification
│   │   └── powershell_openssl_configuration_error.md    --- Fixes for OpenSSL config issues in PowerShell
│   └── PROOFING-HOWTO.md                                --- Step-by-step guide for generate and verify proof packages
├── public-keys/                                     --- Public keys used for signature verification
│   ├── public-key.asc                                   --- ASCII-armored public key file
│   └── cacert.pem                                       --- Certificate authority root certificate
├── tools/                                           --- Scripts for proof generation and verification
│   ├── linux/                                           --- Scripts for Linux/Unix environments*
│   │   ├── .config                                      --- shell script full config with files and steps. 
│   │   ├── proof-repository.sh                          --- Shell script to generate proof package
│   │   └── verify-repository.sh                         --- Shell script to verify proof package
│   └── windows/                                         --- Scripts for Windows environments
│       ├── proof-repository.ps1                         --- PowerShell script to generate proof package
│       ├── proof-repository.bat                         --- Batch script to generate proof package
│       ├── verify-repository.ps1                        --- PowerShell script to verify proof package
│       └── verify-repository.bat                        --- Batch script to verify proof package
├── PROOF_INDEX.md                                   --- Index of all included proof files and their relationships
├── PROOF_INDEX.sig                                  --- Digital signature for the index file
└── HIPO_Proof_certificate.pdf                       --- Official proof certificate issued by HIPO
```

\* Linux scripts tested on Windiws WSL Ubuntu environment. Make sure you have adinistrator right when create new files.

## Intellectual Property and Confidentiality

All materials, documents, and code within this repository and its proof archives are the exclusive intellectual property of Róbert Kovács.
Unauthorized distribution, reproduction, or AI-training use is prohibited.

<div class="page-break"></div>

## Verification Reference

Validation can be performed by matching the SHA-256 checksum in `SHA256SUMS.txt` against the archived repository snapshot (`.zip`), verifying the GPG signature, and validating the RFC 3161 timestamp.

### 1. Recreate or use the provided ZIP archive

If you have access to the Git repository, you can recreate the ZIP snapshot using the exact commit ID:

```bash
git archive --format=zip --output [RepositoryName]-[DATETIME]-[COMMIT_ID].zip
```

Alternatively, use the provided ZIP file in the `PROOFS` directory.

### 2. Compute SHA-256 checksum

Run the following to calculate the checksum of the ZIP file:

```bash
shasum -a 256 [RepositoryName]-[DATETIME]-[COMMIT_ID].zip
```

Compare the output with the corresponding entry in:

```text
SHA256SUMS.txt
```

### 3. Verify GPG signature of the JSON proof

Use the provided public key to verify the signature of `repository-proof.json`:

```bash
gpg --import public-key.asc

gpg --verify repository-proof.json.sig repository-proof.json
```

Expected result:  
Good signature from trusted key  
If signature is invalid or key is missing, verification fails

### 4. Verify RFC 3161 timestamp

Use OpenSSL to verify the timestamp response (`.tsr`) against the query (`.tsq`) and the original data file:

```bash
openssl ts -verify \
  -in [RepositoryName]-[DATETIME]-[COMMIT_ID].zip.tsr \
  -queryfile [RepositoryName]-[DATETIME]-[COMMIT_ID].zip.tsq \
  -data [RepositoryName]-[DATETIME]-[COMMIT_ID].zip \
  -CAfile cacert.pem
```

Expected result:  
Timestamp verification successful  
If the `.tsr` or `.tsq` files are mismatched, verification fails

### 5. Optional: Verify additional files

Repeat steps 2–4 for other files such as:

- `repo_log.txt`
- `repo_log_full.txt`
- `SHA256SUMS.txt`

Each has its own `.tsq` and `.tsr` pair for timestamp verification.

### 6. Use the provided verification script

If available, you can automate all steps using the `verify-repository.sh` script:

```bash
chmod +x verify-repository.sh
dos2unix verify-repository.sh
dos2unix .config

./verify-repository.sh
```

This script should:

- Validate SHA-256 checksums
- Verify GPG signatures
- Check RFC 3161 timestamps
- Log results for audit purposes

## Legal Statement  

> This repository and its contents are the exclusive intellectual property of **Róbert Kovács**.  
> Any registration, reproduction, or filing by a third party without the author's prior written consent shall be considered an infringement.  
> The materials are protected under international copyright conventions and the Paris Convention for the Protection of Industrial Property (1883).  
> Proof of authorship and creation date is established through timestamped commits and certified logs in this repository.

## Contact Information  

**Author / Rights Holder:**  
Róbert Kovács  
<robbi.mobile@gmail.com> | <legal@ncoldwave.com> | <legal@aeternvalens.com>  
Velence, Hungary  

*This file serves as an official proof-of-authorship record for intellectual property verification purposes.  
No source code or confidential content is disclosed within this document.*
