#!/bin/bash

# 🚀 Cursor Rules Project Setup Script
# 新しいプロジェクト用のCursorルール動的参照システム自動セットアップ

set -e  # エラー時に停止

# 色付きログ
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }

# バナー表示
show_banner() {
    echo -e "${BLUE}"
    echo "🚀 ============================================="
    echo "   Cursor Rules Project Setup Script"
    echo "   動的参照システム自動初期化"
    echo "=============================================${NC}"
    echo ""
}

# 設定ファイルの存在確認・作成
setup_config() {
    if [[ ! -f ".cursor-project-config" ]]; then
        log_info "プロジェクト設定ファイルを作成します..."
        
        read -p "プロジェクト名を入力してください: " PROJECT_NAME
        read -p "プロジェクトタイプ (web-app/api/library/tool): " PROJECT_TYPE
        read -p "技術スタック (例: Next.js,Supabase,Vercel): " TECH_STACK
        read -p "チームサイズ (small/medium/large): " TEAM_SIZE
        read -p "GitHubリポジトリURL: " REPO_URL
        
        cat > .cursor-project-config << EOF
# Cursor Rules Project Configuration
PROJECT_NAME="${PROJECT_NAME:-MyProject}"
PROJECT_TYPE="${PROJECT_TYPE:-web-app}"
TECH_STACK="${TECH_STACK:-React,Node.js}"
TEAM_SIZE="${TEAM_SIZE:-small}"
REPO_URL="${REPO_URL:-https://github.com/owner/repo}"
DEVELOPMENT_PERIOD="3months"

# 技術スタック詳細
FRONTEND="$(echo $TECH_STACK | cut -d',' -f1)"
BACKEND="$(echo $TECH_STACK | cut -d',' -f2)"
DATABASE="PostgreSQL"
DEPLOYMENT="Vercel"
AI_LLM="OpenAI"

# チーム設定
TEAM_EXPERIENCE="mixed"
DEVELOPMENT_STYLE="agile"
BRANCH_STRATEGY="github-flow"
CI_CD="github-actions"

# 作成日時
CREATED_DATE="$(date)"
SETUP_VERSION="1.0.0"
EOF
        log_success "設定ファイル(.cursor-project-config)を作成しました"
    fi
    
    # 設定読み込み
    source .cursor-project-config
    log_info "プロジェクト設定を読み込みました: $PROJECT_NAME"
}

# ディレクトリ構造作成
create_directory_structure() {
    log_info "ディレクトリ構造を作成中..."
    
    # 基本ディレクトリ作成
    mkdir -p .cursor/rules/{core,development/{guidelines,patterns,workflows},implementation/{llm,quality,logging},system,metadata,templates/{tech-stack,team-structure},scripts}
    
    # スクリプトディレクトリ
    mkdir -p .cursor/rules/scripts
    
    # GitHub Actions ディレクトリ
    mkdir -p .github/workflows
    
    log_success "ディレクトリ構造を作成しました"
}

# エントリーポイント生成
generate_entry_point() {
    log_info "エントリーポイント(mdc-metadata-manager.mdc)を生成中..."
    
    cat > .cursor/rules/mdc-metadata-manager.mdc << EOF
---
description: ${PROJECT_NAME}プロジェクトのCursorルール動的参照システム・エントリーポイント
globs: ["*"]
alwaysApply: true
---

# 🎯 ${PROJECT_NAME} - Cursorルール管理システム

**策定日**: $(date +%Y年%m月%d日)  
**プロジェクト**: ${PROJECT_NAME}  
**技術スタック**: ${TECH_STACK}  
**チーム規模**: ${TEAM_SIZE}  
**リポジトリ**: ${REPO_URL}

## 🚀 このファイルの役割

### エントリーポイント機能
- **最初の参照**: Cursorが最初に確認するルールファイル
- **参照制御**: ユーザー指示に基づき適切なルールファイルへ誘導
- **構造管理**: 全体の.mdcファイル構造を統制

## 📋 参照制御システム

### 🔴 **常時参照（alwaysApply: true）**

#### 1. **mdc-metadata-manager.mdc** - 本ファイル
- **役割**: エントリーポイント・参照制御
- **参照タイミング**: 全ての操作で最初に参照

#### 2. **mdc-creation-guidelines.mdc**
- **役割**: .mdcファイル作成の品質基準
- **参照タイミング**: .mdcファイル関連作業時

#### 3. **core/project-overview.mdc**
- **役割**: ${PROJECT_NAME}プロジェクト基盤情報
- **参照タイミング**: プロジェクト全体に関わる作業時

#### 4. **core/commit-rules.mdc**
- **役割**: Git操作の品質管理
- **参照タイミング**: コミット・プッシュ作業時

#### 5. **core/cursorrules.mdc**
- **役割**: Cursor AI基本動作ルール
- **参照タイミング**: 全ての操作時

### 🟠 **動的参照（alwaysApply: false）**

#### 技術スタック固有ルール
\`\`\`yaml
${TECH_STACK_RULES}
\`\`\`

#### チーム構成対応ルール
\`\`\`yaml
team-structure/:
  - ${TEAM_SIZE}-team.mdc             # ${TEAM_SIZE}チーム向けルール
\`\`\`

## 🎯 ユーザー指示別参照マトリックス

### 📝 .mdcファイル関連指示
\`\`\`yaml
指示パターン:
  - "新しいルールを作成"
  - "ルールを修正"  
  - "ガイドライン作成"

必須参照:
  - mdc-creation-guidelines.mdc (作成基準)
  - mdc-file-storage-rules.md (格納場所)
\`\`\`

### 🔧 開発・実装指示
\`\`\`yaml
指示パターン:
  - "機能を実装"
  - "バグを修正"
  - "コードを改善"

必須参照:
  - development/workflows/recommended_workflow.mdc
  - core/commit-rules.mdc

条件参照:
  - templates/tech-stack/${FRONTEND,,}-*.mdc (フロントエンド作業時)
  - templates/tech-stack/${BACKEND,,}-*.mdc (バックエンド作業時)
\`\`\`

### 🏗️ ${PROJECT_NAME}固有指示
\`\`\`yaml
指示パターン:
  - "プロジェクト固有の実装"
  - "${PROJECT_TYPE}の開発"
  - "${TECH_STACK}での実装"

必須参照:
  - core/project-overview.mdc
  - templates/tech-stack/ (技術固有ルール)

条件参照:
  - templates/team-structure/${TEAM_SIZE}-team.mdc
\`\`\`

---

## 📁 プロジェクト固有ディレクトリ構造

\`\`\`
.cursor/rules/
├── mdc-metadata-manager.mdc           # 🎯 エントリーポイント
├── mdc-creation-guidelines.mdc        # 📝 作成ガイド
├── mdc-file-storage-rules.md          # 📁 格納ルール
├── project-starter-kit.mdc           # 🚀 スターターキット
├── core/                              # 🏛️ ${PROJECT_NAME}核心ルール
│   ├── cursorrules.mdc               # Cursor基本動作
│   ├── commit-rules.mdc              # Git管理
│   └── project-overview.mdc          # ${PROJECT_NAME}概要
├── development/                       # 🔧 開発関連
│   ├── guidelines/
│   ├── patterns/
│   └── workflows/
├── implementation/                    # 🛠️ 実装関連  
│   ├── llm/
│   ├── quality/
│   └── logging/
├── system/                           # ⚙️ システム関連
└── templates/                        # 📋 ${PROJECT_NAME}特化テンプレート
    ├── tech-stack/                   # ${TECH_STACK}固有ルール
    └── team-structure/               # ${TEAM_SIZE}チーム対応
\`\`\`

---

## 📊 ${PROJECT_NAME}プロジェクト固有設定

### プロジェクト情報
- **タイプ**: ${PROJECT_TYPE}
- **開発期間**: ${DEVELOPMENT_PERIOD}
- **ブランチ戦略**: ${BRANCH_STRATEGY}
- **CI/CD**: ${CI_CD}

### 技術構成
- **フロントエンド**: ${FRONTEND}
- **バックエンド**: ${BACKEND}
- **データベース**: ${DATABASE}
- **デプロイ**: ${DEPLOYMENT}
- **AI/LLM**: ${AI_LLM}

### チーム構成
- **サイズ**: ${TEAM_SIZE}
- **経験レベル**: ${TEAM_EXPERIENCE}
- **開発スタイル**: ${DEVELOPMENT_STYLE}

---

## 📝 更新履歴

| 日付 | 更新内容 | 更新者 |
|------|----------|--------|
| $(date +%Y-%m-%d) | ${PROJECT_NAME}プロジェクト用エントリーポイント自動生成 | Setup Script |

**次回見直し予定**: $(date -d "+1 month" +%Y-%m-%d)  
**管理者**: ${PROJECT_NAME}プロジェクト管理者

---

**🎯 重要**: このファイルは${PROJECT_NAME}プロジェクトのCursorルールシステムの中核です。全ての.mdc関連作業は、このファイルを起点として実行されます。
EOF

    log_success "エントリーポイントを生成しました"
}

# プロジェクト概要生成
generate_project_overview() {
    log_info "プロジェクト概要(project-overview.mdc)を生成中..."
    
    cat > .cursor/rules/core/project-overview.mdc << EOF
---
description: ${PROJECT_NAME}プロジェクトの概要、目標、技術スタック、制約条件を定義
globs: ["*"]
alwaysApply: true
---

# ${PROJECT_NAME} プロジェクト概要

**プロジェクト名**: ${PROJECT_NAME}  
**プロジェクトタイプ**: ${PROJECT_TYPE}  
**作成日**: $(date +%Y年%m月%d日)  
**技術スタック**: ${TECH_STACK}

## 🎯 プロジェクト情報

### 基本情報
- **プロジェクト名**: ${PROJECT_NAME}
- **目標**: [具体的なプロジェクト目標を記述してください]
- **技術スタック**: ${TECH_STACK}
- **開発期間**: ${DEVELOPMENT_PERIOD}
- **リポジトリ**: ${REPO_URL}

### チーム構成
- **チームサイズ**: ${TEAM_SIZE}
- **経験レベル**: ${TEAM_EXPERIENCE}
- **開発スタイル**: ${DEVELOPMENT_STYLE}
- **ブランチ戦略**: ${BRANCH_STRATEGY}

## 🏗️ 技術アーキテクチャ

### フロントエンド
- **主要技術**: ${FRONTEND}
- **UI/UX**: [UIライブラリ・デザインシステムを記述]
- **状態管理**: [状態管理ライブラリを記述]

### バックエンド
- **主要技術**: ${BACKEND}
- **API設計**: [API設計方針を記述]
- **認証・認可**: [認証システムを記述]

### データベース
- **主要技術**: ${DATABASE}
- **データ設計**: [データ設計方針を記述]
- **パフォーマンス**: [パフォーマンス要件を記述]

### インフラ・デプロイ
- **デプロイ先**: ${DEPLOYMENT}
- **CI/CD**: ${CI_CD}
- **監視・ログ**: [監視システムを記述]

### AI/LLM (該当する場合)
- **AI技術**: ${AI_LLM}
- **利用目的**: [AI活用目的を記述]
- **データ処理**: [AI関連データ処理を記述]

## 📋 開発制約・要件

### 技術制約
- [技術的制約事項を列挙]
- [パフォーマンス要件]
- [セキュリティ要件]

### ビジネス制約
- [予算制約]
- [スケジュール制約]
- [リソース制約]

### 品質要件
- [品質基準]
- [テスト要件]
- [ドキュメント要件]

## 🎯 マイルストーン・目標

### Phase 1: 基盤構築 ([予定期間])
- [具体的な成果物・目標を記述]

### Phase 2: 機能開発 ([予定期間])
- [具体的な成果物・目標を記述]

### Phase 3: 最適化・リリース ([予定期間])
- [具体的な成果物・目標を記述]

## 🔗 関連リソース

### ドキュメント
- [設計書・仕様書のリンク]
- [API文書のリンク]

### 外部サービス・ツール
- [使用する外部サービス一覧]
- [開発ツール一覧]

### 参考資料
- [技術参考資料]
- [ベストプラクティス資料]

---

## 📝 プロジェクト固有ルール

### 開発ルール
- [${PROJECT_NAME}固有の開発ルール]

### コーディング規約
- [プロジェクト固有のコーディング規約]

### レビュー・品質管理
- [レビュープロセス]
- [品質チェック項目]

---

## 📊 更新履歴

| 日付 | 更新内容 | 更新者 |
|------|----------|--------|
| $(date +%Y-%m-%d) | ${PROJECT_NAME}プロジェクト概要自動生成 | Setup Script |

**次回見直し予定**: $(date -d "+2 weeks" +%Y-%m-%d)  
**管理者**: ${PROJECT_NAME}プロジェクト管理者

---

**📝 TODO**: 
- [ ] プロジェクト目標の詳細記述
- [ ] 技術的制約の追加
- [ ] マイルストーンの具体化
- [ ] 関連リソースのリンク追加

**🎯 重要**: このファイルは${PROJECT_NAME}プロジェクトの基盤情報です。プロジェクト進行に応じて定期的に更新してください。
EOF

    log_success "プロジェクト概要を生成しました"
}

# 基本ルールファイル生成
generate_basic_rules() {
    log_info "基本ルールファイルを生成中..."
    
    # cursorrules.mdc生成
    cat > .cursor/rules/core/cursorrules.mdc << EOF
---
description: ${PROJECT_NAME}プロジェクト用Cursor AI基本動作ルール・コーディング支援設定
globs: ["*"]
alwaysApply: true
---

# ${PROJECT_NAME} - Cursor AI 基本動作ルール

## 🎯 ${PROJECT_NAME}プロジェクト基本方針

### プロジェクト情報の理解
- **プロジェクト名**: ${PROJECT_NAME}
- **技術スタック**: ${TECH_STACK}
- **チーム規模**: ${TEAM_SIZE}
- **開発期間**: ${DEVELOPMENT_PERIOD}

### 基本的な応答ルール
- 常に日本語で返答する
- ${PROJECT_NAME}プロジェクトの文脈を理解して回答する
- ${TECH_STACK}技術スタックに特化した提案をする
- ${TEAM_SIZE}チーム向けの実用的なアドバイスを提供する

## 🔧 技術スタック固有ルール

### ${FRONTEND} 関連
- [${FRONTEND}固有のベストプラクティスを記述]
- [コンポーネント設計方針]
- [状態管理方針]

### ${BACKEND} 関連  
- [${BACKEND}固有のベストプラクティスを記述]
- [API設計方針]
- [エラーハンドリング方針]

## 📋 ${PROJECT_NAME}コーディング規約

### ファイル・ディレクトリ命名
- [プロジェクト固有の命名規約]

### 関数・変数命名
- [命名規約の詳細]

### コメント・ドキュメント
- [ドキュメント作成方針]

---

**📝 更新履歴**: $(date +%Y-%m-%d) - ${PROJECT_NAME}用自動生成
EOF

    # commit-rules.mdc生成（汎用版をコピー）
    if [[ -f ".cursor/rules/core/commit-rules.mdc" ]]; then
        log_info "commit-rules.mdcは既に存在するためスキップします"
    else
        cat > .cursor/rules/core/commit-rules.mdc << EOF
---
description: Git操作の品質管理・セキュリティ確保のためのコミット・プッシュルール
globs: ["*"]
alwaysApply: true
---

# Git コミット・プッシュルール

## 🎯 ${PROJECT_NAME}プロジェクト Git管理方針

### ブランチ戦略
- **戦略**: ${BRANCH_STRATEGY}
- **主要ブランチ**: main/master
- **開発ブランチ**: feature/*, fix/*, hotfix/*

### コミットメッセージ規約
\`\`\`
<type>: <概要>

<詳細な説明>
- 変更点1
- 変更点2
\`\`\`

#### タイプ
- feat: 新機能追加
- fix: バグ修正  
- docs: ドキュメント更新
- style: スタイル変更
- refactor: リファクタリング
- test: テスト追加・修正
- chore: その他の変更

## 📋 プッシュ前チェックリスト

### 必須確認事項
- [ ] コードが正常に動作する
- [ ] テストが通る
- [ ] リント・フォーマットエラーがない
- [ ] 機密情報が含まれていない
- [ ] .gitignoreが適切に設定されている

### ${PROJECT_NAME}固有チェック
- [ ] [プロジェクト固有のチェック項目]

---

**📝 更新日**: $(date +%Y-%m-%d) - ${PROJECT_NAME}用設定
EOF
    fi
    
    log_success "基本ルールファイルを生成しました"
}

# GitHub Actions ワークフロー生成
generate_github_actions() {
    log_info "GitHub Actions ワークフローを生成中..."
    
    cat > .github/workflows/cursor-rules-check.yml << EOF
name: ${PROJECT_NAME} - Cursor Rules Quality Check

on:
  push:
    paths:
      - '.cursor/rules/**'
  pull_request:
    paths:
      - '.cursor/rules/**'

jobs:
  rules-validation:
    runs-on: ubuntu-latest
    name: Cursor Rules Validation
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        
      - name: Validate Rules Structure
        run: |
          echo "🔍 ${PROJECT_NAME} Cursorルール構造チェック開始..."
          
          # 必須ファイル存在チェック
          required_files=(
            ".cursor/rules/mdc-metadata-manager.mdc"
            ".cursor/rules/mdc-creation-guidelines.mdc"
            ".cursor/rules/core/cursorrules.mdc"
            ".cursor/rules/core/project-overview.mdc"
            ".cursor/rules/core/commit-rules.mdc"
          )
          
          for file in "\${required_files[@]}"; do
            if [[ ! -f "\$file" ]]; then
              echo "❌ 必須ファイルが見つかりません: \$file"
              exit 1
            fi
          done
          
          echo "✅ 必須ファイル存在確認完了"
          
      - name: Validate Frontmatter
        run: |
          echo "📝 Frontmatter完全性チェック開始..."
          
          errors=0
          for file in \$(find .cursor/rules -name "*.mdc"); do
            echo "チェック中: \$file"
            
            if ! head -10 "\$file" | grep -q "description:"; then
              echo "❌ description不足: \$file"
              ((errors++))
            fi
            
            if ! head -10 "\$file" | grep -q "alwaysApply:"; then
              echo "❌ alwaysApply不足: \$file"
              ((errors++))
            fi
          done
          
          if [[ \$errors -gt 0 ]]; then
            echo "❌ Frontmatterエラー: \$errors 個"
            exit 1
          fi
          
          echo "✅ Frontmatterチェック完了"
          
      - name: Generate Rules Report
        run: |
          echo "# 📊 ${PROJECT_NAME} Cursor Rules システム状況" > rules-report.md
          echo "" >> rules-report.md
          echo "**生成日時**: \$(date)" >> rules-report.md
          echo "**プロジェクト**: ${PROJECT_NAME}" >> rules-report.md
          echo "**技術スタック**: ${TECH_STACK}" >> rules-report.md
          echo "" >> rules-report.md
          
          echo "## 📋 基本統計" >> rules-report.md
          total_mdc=\$(find .cursor/rules -name "*.mdc" | wc -l)
          always_apply_true=\$(grep -r "alwaysApply: true" .cursor/rules/ --include="*.mdc" | wc -l)
          always_apply_false=\$(grep -r "alwaysApply: false" .cursor/rules/ --include="*.mdc" | wc -l)
          
          echo "- 総.mdcファイル数: \$total_mdc" >> rules-report.md
          echo "- 常時参照(alwaysApply: true): \$always_apply_true" >> rules-report.md
          echo "- 動的参照(alwaysApply: false): \$always_apply_false" >> rules-report.md
          echo "" >> rules-report.md
          
          echo "## 🎯 ${PROJECT_NAME}プロジェクト固有設定" >> rules-report.md
          echo "- プロジェクトタイプ: ${PROJECT_TYPE}" >> rules-report.md
          echo "- チームサイズ: ${TEAM_SIZE}" >> rules-report.md
          echo "- ブランチ戦略: ${BRANCH_STRATEGY}" >> rules-report.md
          
      - name: Comment PR with Report
        if: github.event_name == 'pull_request'
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const report = fs.readFileSync('rules-report.md', 'utf8');
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: \`## 📋 ${PROJECT_NAME} Cursor Rules Quality Report\\n\\n\${report}\`
            });

  project-validation:
    runs-on: ubuntu-latest
    name: ${PROJECT_NAME} Project Validation
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        
      - name: Validate Project Configuration
        run: |
          echo "🔍 ${PROJECT_NAME} プロジェクト設定検証開始..."
          
          # プロジェクト設定ファイル確認
          if [[ -f ".cursor-project-config" ]]; then
            echo "✅ プロジェクト設定ファイル存在確認"
            source .cursor-project-config
            echo "プロジェクト名: \$PROJECT_NAME"
            echo "技術スタック: \$TECH_STACK"
          else
            echo "⚠️ プロジェクト設定ファイルが見つかりません"
          fi
          
          # ${TECH_STACK}固有の検証
          echo "🔧 技術スタック固有検証: ${TECH_STACK}"
          # [必要に応じて技術固有の検証を追加]
          
          echo "✅ ${PROJECT_NAME}プロジェクト検証完了"
EOF

    log_success "GitHub Actions ワークフローを生成しました"
}

# 実装ログシステム生成
generate_implementation_logging() {
    log_info "実装ログシステムを生成中..."
    
    # 実装ログディレクトリ作成
    mkdir -p .cursor/rules/implementation/logging
    mkdir -p .cursor/rules/templates
    
    # 実装ログルール生成
    cat > .cursor/rules/implementation/logging/implementation-log-rules.mdc << EOF
---
description: ${PROJECT_NAME}プロジェクト用実装ログ作成・管理ルール
globs: ["*"]
alwaysApply: true
---

# ${PROJECT_NAME} - 実装ログ作成ルール

## 🎯 実装ログの目的

### ${PROJECT_NAME}での実装記録
- **進捗の可視化**: 開発プロセスの透明性確保
- **知識の蓄積**: 解決手法・パターンの体系化
- **品質の向上**: 振り返りによる継続的改善

## 📋 実装完了の判定基準

### 実装完了条件
- エラーが完全になくなった状態
- ユーザーから動作確認・承認が取れた場合
- 機能が期待通りに動作することが確認された場合

## 🔄 実装ログの2軸構成

### 1. フロー（Flow）- 日次実装ログ
**目的**: その日の実装過程を時系列で記録
**形式**: \`IMPLEMENTATION_LOG_YYYY-MM-DD.md\`

**構成テンプレート**:
\`\`\`markdown
# ${PROJECT_NAME} 実装ログ - YYYY年MM月DD日

## 実装項目: [項目名]
**開始時刻**: HH:MM  
**完了時刻**: HH:MM  
**所要時間**: X時間Y分

### 実装概要
- 目的: [何を実装したか]
- 対象ファイル: [変更したファイル一覧]
- 主な変更内容: [変更の概要]

### 実装プロセス
1. **調査・分析フェーズ**
   - 問題の特定
   - 既存コードの調査
   - 解決方針の決定

2. **実装フェーズ**
   - 具体的な実装手順
   - 遭遇した問題と解決方法
   - コードの変更詳細

3. **テスト・検証フェーズ**
   - 動作確認方法
   - 発生したエラーと対処
   - 最終的な動作確認結果

### 技術的な学び
- 新しく学んだ技術・概念
- 効果的だった解決アプローチ
- 今後活用できる知識

### 改善点・反省点
- より効率的にできたであろう方法
- 見落としていた点
- 次回に活かすべき教訓
\`\`\`

### 2. ストック（Stock）- 知識蓄積システム
**目的**: 日々の学びを一般化してCursorルールに昇華
**形式**: Cursorルールファイルへの追加提案

**プロセス**:
1. 実装完了後、学びを抽象化
2. Cursorルールとして有効な内容を特定
3. ユーザーに提案・承認を求める
4. 承認後、適切なルールファイルに追加

## ⚡ 自動実行タイミング

### 実装ログ作成の自動実行
- ユーザーが「動作確認できました」「問題ありません」「完了しました」等の承認を示した場合
- エラーが解消され、機能が正常に動作することが確認された場合
- 開発項目が完全に完了した場合

### 実行プロセス
1. **フロー（日次ログ）**: 必ず作成
2. **ストック（ルール提案）**: 学びがある場合のみ提案
3. **ユーザー承認**: Cursorルールへの追加は承認後のみ

---

**📝 ${PROJECT_NAME} 実装ログシステム**: $(date +%Y-%m-%d)自動生成
EOF

    # 実装ログストック管理ルール生成
    cat > .cursor/rules/implementation/logging/implementation-log-stock.mdc << EOF
---
description: ${PROJECT_NAME}プロジェクト用実装ログの知識ストック化・Cursorルール昇華管理
globs: ["*.mdc", "*.md"]
alwaysApply: false
---

# ${PROJECT_NAME} - 実装ログ知識ストック管理

## 🎯 知識ストック化の目的

### ${PROJECT_NAME}での知識体系化
- **学習の定着**: 個別経験を一般化された知識に変換
- **チーム共有**: 個人の学びをチーム全体の資産に
- **品質向上**: 蓄積された知識による開発効率・品質の向上

## 📚 ストック化プロセス

### Phase 1: 学びの抽出
\`\`\`yaml
対象となる学び:
  - 新しい技術・概念の習得
  - 効果的な解決アプローチの発見
  - よくある問題と解決パターン
  - ${TECH_STACK}固有のベストプラクティス
  - ${TEAM_SIZE}チーム向け開発手法
\`\`\`

### Phase 2: 一般化・抽象化
\`\`\`yaml
抽象化の観点:
  - プロジェクト固有 → 一般的な原則
  - 具体的手順 → 再利用可能なパターン
  - 個人経験 → チーム標準手法
  - 技術詳細 → 設計原則
\`\`\`

### Phase 3: Cursorルール提案
\`\`\`markdown
## 新しいCursorルール提案

### 学びの背景
[今回の実装で得られた具体的な経験]

### 抽象化されたルール
[一般的な開発に適用可能な形に抽象化されたルール]

### 適用場面
[このルールが有効な場面・条件]

### 期待される効果
[このルールを適用することで得られる効果]

### 提案先ファイル
[追加先のCursorルールファイル名]
\`\`\`

## 🔄 ${PROJECT_NAME}固有ストック戦略

### 技術スタック特化ストック
\`\`\`yaml
${TECH_STACK}関連:
  - フロントエンド: ${FRONTEND}のベストプラクティス
  - バックエンド: ${BACKEND}の実装パターン
  - インフラ: ${DEPLOYMENT}の運用知識
\`\`\`

### チーム規模対応ストック
\`\`\`yaml
${TEAM_SIZE}チーム向け:
  - コミュニケーション効率化
  - 作業分担最適化
  - コードレビュー改善
\`\`\`

## 📊 ストック管理・活用

### 定期レビュー
- **週次**: 蓄積された学びの確認
- **月次**: Cursorルール提案の整理
- **四半期**: ストック戦略の見直し

### 品質管理
- **重複チェック**: 既存ルールとの重複回避
- **一貫性確認**: プロジェクト全体との整合性
- **実用性検証**: 実際の開発での有効性確認

---

**📚 ${PROJECT_NAME} 知識ストックシステム**: $(date +%Y-%m-%d)自動生成
EOF

    # 実装ログテンプレート生成
    cat > .cursor/rules/templates/implementation-log-template.md << EOF
# ${PROJECT_NAME} 実装ログ - $(date +%Y年%m月%d日)

## 実装項目: [具体的な実装内容]
**開始時刻**: $(date +%H:%M)  
**完了時刻**: [完了時に記入]  
**所要時間**: [所要時間を記入]

## 実装概要
- **目的**: [何を達成しようとしたか]
- **対象ファイル**: [変更したファイル一覧]
- **主な変更内容**: [変更の概要]

## 実装プロセス

### 1. 調査・分析フェーズ
- **問題の特定**: 
- **既存コードの調査**: 
- **解決方針の決定**: 

### 2. 実装フェーズ
- **具体的な実装手順**: 
- **遭遇した問題と解決方法**: 
- **コードの変更詳細**: 

### 3. テスト・検証フェーズ
- **動作確認方法**: 
- **発生したエラーと対処**: 
- **最終的な動作確認結果**: 

## 技術的な学び
- **新しく学んだ技術・概念**: 
- **効果的だった解決アプローチ**: 
- **今後活用できる知識**: 

## 改善点・反省点
- **より効率的にできたであろう方法**: 
- **見落としていた点**: 
- **次回に活かすべき教訓**: 

## ${PROJECT_NAME}固有の学び
- **${TECH_STACK}関連の知見**: 
- **${TEAM_SIZE}チーム開発での気づき**: 
- **プロジェクト固有の制約・解決策**: 

---

**📝 実装完了日**: $(date +%Y年%m月%d日)  
**実装者**: [実装者名]  
**レビュー状況**: [レビュー状況]
EOF

    log_success "実装ログシステムを生成しました"
}

# 技術スタック固有ルール生成
generate_tech_specific_rules() {
    log_info "技術スタック固有ルールを生成中..."
    
    # フロントエンド固有ルール
    if [[ "${FRONTEND,,}" == *"next"* ]] || [[ "${FRONTEND,,}" == *"react"* ]]; then
        cat > .cursor/rules/templates/tech-stack/react-nextjs.mdc << EOF
---
description: React/Next.js技術スタック固有の開発ルール・ベストプラクティス（${PROJECT_NAME}プロジェクト用）
globs: ["app/**/*", "components/**/*", "pages/**/*", "src/**/*", "*.tsx", "*.jsx"]
alwaysApply: false
---

# ${PROJECT_NAME} - React/Next.js 開発ルール

## 🎯 ${PROJECT_NAME}での技術要件

### Next.js要件
- App Router使用（Next.js 13+）
- Server Componentsの積極活用
- Client Componentsは必要最小限に

### React要件
- 関数コンポーネント使用
- Hooksベースの状態管理
- TypeScript必須

## 📋 ${PROJECT_NAME}ファイル構成

\`\`\`
app/                     # Next.js App Router
├── (auth)/             # 認証関連ページ
├── dashboard/          # ダッシュボード  
├── api/               # API Routes
└── globals.css        # グローバルスタイル

components/             # 再利用可能コンポーネント
├── ui/                # shadcn/ui等のUIコンポーネント
├── forms/             # フォーム専用コンポーネント
└── ${PROJECT_NAME,,}/ # ${PROJECT_NAME}固有コンポーネント

lib/                   # ユーティリティ・設定
├── utils/             # ヘルパー関数
└── types/             # TypeScript型定義
\`\`\`

## 🔧 ${PROJECT_NAME}実装パターン

### コンポーネント作成
\`\`\`typescript
// ${PROJECT_NAME}コンポーネントテンプレート
interface ${PROJECT_NAME}ComponentProps {
  // プロパティ定義
}

export function ${PROJECT_NAME}Component({ ...props }: ${PROJECT_NAME}ComponentProps) {
  // 実装
}
\`\`\`

---

**📝 ${PROJECT_NAME}固有設定**: $(date +%Y-%m-%d)自動生成
EOF
    fi
    
    # バックエンド固有ルール
    if [[ "${BACKEND,,}" == *"supabase"* ]]; then
        cat > .cursor/rules/templates/tech-stack/supabase.mdc << EOF
---
description: Supabase技術スタック固有の開発ルール・ベストプラクティス（${PROJECT_NAME}プロジェクト用）
globs: ["supabase/**/*", "lib/supabase/**/*", "lib/database/**/*"]
alwaysApply: false
---

# ${PROJECT_NAME} - Supabase 開発ルール

## 🎯 ${PROJECT_NAME}でのSupabase要件

### セキュリティ要件
- Row Level Security (RLS)必須
- 適切なポリシー設定
- 機密データの暗号化

### 型安全性
- supabase-js使用
- TypeScript型生成・活用
- リアルタイム機能の適切な使用

## 📋 ${PROJECT_NAME}ディレクトリ構成

\`\`\`
supabase/
├── migrations/         # データベースマイグレーション
├── functions/         # Edge Functions
└── config.toml       # Supabase設定

lib/supabase/
├── client.ts         # Supabaseクライアント設定
├── types.ts          # データベース型定義
└── queries/          # クエリ関数集
\`\`\`

## 🔧 ${PROJECT_NAME}実装パターン

### データベースアクセス
\`\`\`typescript
// ${PROJECT_NAME}用Supabaseクライアント
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
)
\`\`\`

---

**📝 ${PROJECT_NAME}固有設定**: $(date +%Y-%m-%d)自動生成
EOF
    fi
    
    log_success "技術スタック固有ルールを生成しました"
}

# チーム規模固有ルール生成
generate_team_specific_rules() {
    log_info "チーム規模固有ルールを生成中..."
    
    cat > .cursor/rules/templates/team-structure/${TEAM_SIZE}-team.mdc << EOF
---
description: ${TEAM_SIZE}規模チーム向けの開発ルール・ワークフロー（${PROJECT_NAME}プロジェクト用）
globs: ["*"]
alwaysApply: false
---

# ${PROJECT_NAME} - ${TEAM_SIZE}チーム開発ルール

## 🎯 ${TEAM_SIZE}チーム特化要件

$(
case ${TEAM_SIZE} in
  "small")
    echo "### 軽量プロセス"
    echo "- 過度なドキュメントは不要"
    echo "- 直接コミュニケーション重視"
    echo "- 迅速な意思決定"
    echo ""
    echo "### シンプルワークフロー"
    echo "- GitHub Flow採用"
    echo "- Feature branchは短期間"
    echo "- 迅速なマージ・デプロイ"
    ;;
  "medium")
    echo "### バランス型プロセス"
    echo "- 必要最小限のドキュメント"
    echo "- 定期的なチームミーティング"
    echo "- 段階的な意思決定"
    echo ""
    echo "### 標準ワークフロー"
    echo "- Git Flow または GitHub Flow"
    echo "- コードレビュー必須"
    echo "- 品質ゲート設定"
    ;;
  "large")
    echo "### 構造化プロセス"
    echo "- 包括的なドキュメント"
    echo "- 正式なミーティング・承認プロセス"
    echo "- リスク管理・品質保証"
    echo ""
    echo "### エンタープライズワークフロー"
    echo "- Git Flow採用"
    echo "- 多段階レビュー"
    echo "- 自動化された品質チェック"
    ;;
esac
)

## 📋 ${PROJECT_NAME}での${TEAM_SIZE}チーム運用

### コミュニケーション
$(
case ${TEAM_SIZE} in
  "small")
    echo "- Slack/Discord等での即座連絡"
    echo "- 週1回の簡単な進捗共有"
    echo "- 問題発生時の即座相談"
    ;;
  "medium")
    echo "- 定期ミーティング（週2回）"
    echo "- 進捗管理ツール活用"
    echo "- チーム内ペアプログラミング"
    ;;
  "large")
    echo "- 正式なスタンドアップミーティング"
    echo "- プロジェクト管理ツール必須"
    echo "- クロスファンクショナルチーム運営"
    ;;
esac
)

### タスク管理
$(
case ${TEAM_SIZE} in
  "small")
    echo "- GitHub Issues or 簡単なToDoリスト"
    echo "- 個人責任制"
    echo "- 柔軟な優先順位変更"
    ;;
  "medium")
    echo "- GitHub Projects or Trello"
    echo "- スプリント計画"
    echo "- 定期的な振り返り"
    ;;
  "large")
    echo "- Jira等の本格的プロジェクト管理"
    echo "- エピック・ユーザーストーリー管理"
    echo "- メトリクス・KPI追跡"
    ;;
esac
)

---

**📝 ${PROJECT_NAME} ${TEAM_SIZE}チーム設定**: $(date +%Y-%m-%d)自動生成
EOF

    log_success "チーム規模固有ルールを生成しました"
}

# README更新
update_readme() {
    log_info "README.mdを更新中..."
    
    # README.mdが存在しない場合は作成
    if [[ ! -f "README.md" ]]; then
        cat > README.md << EOF
# ${PROJECT_NAME}

**プロジェクトタイプ**: ${PROJECT_TYPE}  
**技術スタック**: ${TECH_STACK}  
**チーム規模**: ${TEAM_SIZE}  
**作成日**: $(date +%Y年%m月%d日)

## 📋 プロジェクト概要

[プロジェクトの概要を記述してください]

## 🚀 技術スタック

### フロントエンド
- **${FRONTEND}**: [説明]

### バックエンド  
- **${BACKEND}**: [説明]

### その他
- **データベース**: ${DATABASE}
- **デプロイ**: ${DEPLOYMENT}
- **AI/LLM**: ${AI_LLM}

## 🔧 開発環境セットアップ

\`\`\`bash
# リポジトリクローン
git clone ${REPO_URL}
cd ${PROJECT_NAME,,}

# 依存関係インストール
[インストールコマンドを記述]

# 開発サーバー起動
[起動コマンドを記述]
\`\`\`

## 📚 Cursor Rules システム

このプロジェクトでは、Cursor AI の開発効率を最大化するため、包括的なルールシステムを導入しています。

### 基本構成
- **エントリーポイント**: \`.cursor/rules/mdc-metadata-manager.mdc\`
- **プロジェクト概要**: \`.cursor/rules/core/project-overview.mdc\`
- **技術固有ルール**: \`.cursor/rules/templates/tech-stack/\`
- **チーム固有ルール**: \`.cursor/rules/templates/team-structure/\`

### 使用方法
1. Cursor でプロジェクトを開く
2. 自動的にルールが適用される  
3. プロジェクト固有の支援を受ける

## 🤝 開発ワークフロー

### ブランチ戦略
- **戦略**: ${BRANCH_STRATEGY}
- **メインブランチ**: main
- **開発ブランチ**: feature/*, fix/*, hotfix/*

### コミット規約
\`\`\`
<type>: <概要>

<詳細説明>
\`\`\`

### タイプ
- \`feat\`: 新機能追加
- \`fix\`: バグ修正
- \`docs\`: ドキュメント更新
- \`style\`: スタイル変更
- \`refactor\`: リファクタリング
- \`test\`: テスト追加・修正
- \`chore\`: その他の変更

## 📊 プロジェクト管理

### ${TEAM_SIZE}チーム構成
- **経験レベル**: ${TEAM_EXPERIENCE}
- **開発スタイル**: ${DEVELOPMENT_STYLE}
- **コミュニケーション**: [使用ツール・方法]

### マイルストーン
- **Phase 1**: [目標・期間]
- **Phase 2**: [目標・期間]  
- **Phase 3**: [目標・期間]

## 🔗 関連リンク

- **リポジトリ**: ${REPO_URL}
- **デプロイ先**: [デプロイURL]
- **ドキュメント**: [ドキュメントURL]

## 📝 ライセンス

[ライセンス情報]

---

**最終更新**: $(date +%Y年%m月%d日)  
**Cursor Rules バージョン**: 1.0.0
EOF
    else
        # 既存README.mdにCursor Rules セクションを追加
        if ! grep -q "Cursor Rules システム" README.md; then
            cat >> README.md << EOF

## 📚 Cursor Rules システム

このプロジェクト（${PROJECT_NAME}）では、Cursor AI の開発効率を最大化するため、包括的なルールシステムを導入しています。

### 基本構成
- **エントリーポイント**: \`.cursor/rules/mdc-metadata-manager.mdc\`
- **プロジェクト概要**: \`.cursor/rules/core/project-overview.mdc\`
- **技術固有ルール**: \`.cursor/rules/templates/tech-stack/\`（${TECH_STACK}対応）
- **チーム固有ルール**: \`.cursor/rules/templates/team-structure/\`（${TEAM_SIZE}チーム対応）

### システム特徴
- **動的参照**: 必要な時に必要なルールのみ参照
- **プロジェクト特化**: ${PROJECT_NAME}の技術・チーム構成に最適化
- **自動品質管理**: GitHub Actions による継続的品質チェック

---
**Cursor Rules セットアップ日**: $(date +%Y年%m月%d日)
EOF
        fi
    fi
    
    log_success "README.mdを更新しました"
}

# メイン実行関数
main() {
    show_banner
    
    log_info "${PROJECT_NAME:-新規プロジェクト}のCursorルールシステムセットアップを開始します..."
    echo ""
    
    # フェーズ実行
    setup_config
    create_directory_structure
    generate_entry_point
    generate_project_overview
    generate_basic_rules
    generate_implementation_logging
    generate_github_actions
    generate_tech_specific_rules
    generate_team_specific_rules
    update_readme
    
    echo ""
    log_success "🎉 Cursorルールシステムセットアップが完了しました！"
    echo ""
    echo -e "${GREEN}📝 次のステップ:${NC}"
    echo "1. .cursor/rules/core/project-overview.mdc を編集してプロジェクト詳細を記述"
    echo "2. 技術スタック固有の設定を .cursor/rules/templates/tech-stack/ で確認・調整"
    echo "3. Cursor でプロジェクトを開いて動的参照システムを体験"
    echo "4. Git コミット・プッシュで GitHub Actions 品質チェックを確認"
    echo ""
    echo -e "${BLUE}📊 生成されたファイル:${NC}"
    find .cursor/rules -name "*.mdc" -o -name "*.md" | head -10
    echo ""
    echo -e "${YELLOW}⚠️  重要: .cursor-project-config ファイルには機密情報を含めないでください${NC}"
}

# スクリプト実行
main "$@" 