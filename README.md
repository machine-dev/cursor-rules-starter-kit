# 🚀 Cursor Rules Project Starter Kit

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

> **新規プロジェクトで即座にCursor AI開発環境を構築できるスターターキット**

## 🎯 概要

このスターターキットは、**どんなプロジェクトでも3分以内にCursor AIの高度な開発環境を構築**できるツールセットです。

### ✨ 主な特徴

- 🚀 **ワンクリック導入**: 複雑な設定なしで即座開始
- 🎛️ **プロジェクト自動適応**: 技術スタック・チーム構成に応じた自動カスタマイズ
- 📊 **実装ログシステム**: 進捗記録と知識蓄積の自動化
- 🔄 **動的参照制御**: 状況に応じた適切なルール適用
- 🛠️ **CI/CD統合**: 継続的品質管理とレポート生成

---

## 🚀 クイックスタート

### **Step 1: このリポジトリをクローン**
```bash
git clone https://github.com/machine-dev/cursor-rules-starter-kit.git
cd cursor-rules-starter-kit
```

### **Step 2: 新規プロジェクトディレクトリに移動**
```bash
cd /path/to/your/new/project
```

### **Step 3: Starter Kitファイルをコピー**
```bash
# .cursorディレクトリが存在しない場合は作成
mkdir -p .cursor

# Starter Kit全体をコピー
cp -r /path/to/cursor-rules-starter-kit/.cursor/rules .cursor/

# 実行権限を付与
chmod +x .cursor/rules/scripts/*.sh
```

### **Step 4: 自動セットアップ実行**
```bash
# プロジェクト固有設定の自動生成
./.cursor/rules/scripts/cursor-rules-setup.sh

# 設定完了後、構造検証
./.cursor/rules/scripts/validate-structure.sh

# システム状況レポート生成
./.cursor/rules/scripts/generate-report.sh
```

**🎉 完了！** Cursor AIが即座にプロジェクトに最適化された状態で利用開始できます。

---

## 📁 ファイル構成

```
cursor-rules-starter-kit/
├── .cursor/rules/
│   ├── project-starter-kit.mdc          # メインスターターキット
│   ├── mdc-metadata-manager.mdc          # エントリーポイント・参照制御
│   ├── mdc-creation-guidelines.mdc       # ファイル作成ガイドライン
│   ├── mdc-file-storage-rules.md         # 格納場所ルール
│   ├── QUICKSTART.md                     # 詳細セットアップガイド
│   └── scripts/
│       ├── cursor-rules-setup.sh         # 🔧 自動セットアップ
│       ├── validate-structure.sh         # ✅ 構造検証
│       └── generate-report.sh            # 📊 状況レポート生成
├── README.md                             # 本ファイル
└── LICENSE                               # ライセンス
```

---

## 🤝 コントリビューション

### **貢献方法**
1. **Issue**: バグ報告・機能要望
2. **Pull Request**: 改善・新機能追加
3. **フィードバック**: 使用体験・改善提案

### **開発環境**
```bash
# リポジトリクローン
git clone https://github.com/machine-dev/cursor-rules-starter-kit.git

# 開発ブランチ作成
git checkout -b feature/your-feature-name

# 変更実装・テスト
./scripts/validate-structure.sh

# プルリクエスト作成
```

---

## 📋 ライセンス

このプロジェクトは[MIT License](LICENSE)の下で公開されています。

---

## 🔗 関連リンク

- **Cursor AI公式**: https://cursor.sh/
- **Documentation**: [QUICKSTART.md](.cursor/rules/QUICKSTART.md)
- **Issues**: GitHub Issues
- **Discussions**: GitHub Discussions

---

## 🏷️ タグ

`cursor-ai` `development-tools` `automation` `project-setup` `ai-assisted-development` `typescript` `javascript` `productivity` `developer-experience` `code-quality`

---

**�� 今すぐ始めて、Cursor AIの真の力を体験してください！**
