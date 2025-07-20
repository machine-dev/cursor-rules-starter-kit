# 🚀 Cursor Rules Project Starter Kit - クイックスタートガイド

**バージョン**: 1.0.0  
**作成日**: 2025年7月20日  
**対象**: 新規プロジェクト開発者・チームリーダー

## 🎯 このガイドの目的

新しいプロジェクトでCursor AI開発支援システムを**10分以内**で導入し、即座に高品質な開発環境を構築する。

---

## ⚡ 10分間セットアップ

### Step 1: 前提条件確認（30秒）

```bash
# 必要ツールの確認
which git && which bash && echo "✅ 基本ツール確認完了"

# プロジェクトディレクトリに移動
cd /path/to/your/project
```

### Step 2: スターターキット実行（2分）

```bash
# スクリプトダウンロード・実行
curl -sSL https://raw.githubusercontent.com/your-org/cursor-rules-starter/main/setup.sh | bash

# または、既存のGenerative BIプロジェクトからコピー
cp -r /path/to/GenerativeBI/.cursor/rules ./cursor/
cp /path/to/GenerativeBI/.cursor/rules/scripts/cursor-rules-setup.sh .
chmod +x cursor-rules-setup.sh
./cursor-rules-setup.sh
```

**設定例**:
```
プロジェクト名: MyAwesomeApp
プロジェクトタイプ: web-app
技術スタック: Next.js,Supabase,Vercel
チームサイズ: small
GitHubリポジトリURL: https://github.com/yourusername/myawesomeapp
```

### Step 3: プロジェクト設定編集（3分）

```bash
# プロジェクト概要をカスタマイズ
code .cursor/rules/core/project-overview.mdc
```

**編集ポイント**:
- プロジェクト目標の具体化
- 技術的制約の追加
- マイルストーンの設定

### Step 4: Cursor起動・確認（1分）

```bash
# Cursorでプロジェクトを開く
cursor .

# エントリーポイント確認
code .cursor/rules/mdc-metadata-manager.mdc
```

### Step 5: 動作確認（3分）

```bash
# システム状況確認
./.cursor/rules/scripts/validate-structure.sh

# レポート生成
./.cursor/rules/scripts/generate-report.sh > cursor-rules-report.md
```

### Step 6: Git設定（1分）

```bash
# Cursor Rulesをコミット
git add .cursor/ .cursor-project-config
git commit -m "feat: add Cursor Rules dynamic reference system"
git push
```

---

## 🔧 技術スタック別セットアップ

### Next.js + Supabase + Vercel

```bash
# 技術固有設定
PROJECT_TYPE="web-app"
TECH_STACK="Next.js,Supabase,Vercel"
FRONTEND="Next.js"
BACKEND="Supabase"
DEPLOYMENT="Vercel"

# 自動生成される技術固有ルール
# - .cursor/rules/templates/tech-stack/react-nextjs.mdc
# - .cursor/rules/templates/tech-stack/supabase.mdc
```

### React + Node.js + AWS

```bash
# 技術固有設定
PROJECT_TYPE="web-app"
TECH_STACK="React,Node.js,AWS"
FRONTEND="React"
BACKEND="Node.js"
DEPLOYMENT="AWS"

# 手動作成推奨ルール
# - .cursor/rules/templates/tech-stack/nodejs.mdc
# - .cursor/rules/templates/tech-stack/aws.mdc
```

### Vue.js + Python + Docker

```bash
# 技術固有設定
PROJECT_TYPE="web-app"
TECH_STACK="Vue.js,Python,Docker"
FRONTEND="Vue.js"
BACKEND="Python"
DEPLOYMENT="Docker"

# 手動作成推奨ルール
# - .cursor/rules/templates/tech-stack/vue.mdc
# - .cursor/rules/templates/tech-stack/python.mdc
```

---

## 👥 チームサイズ別推奨設定

### Small Team (1-3人)

```yaml
特徴:
  - 軽量プロセス
  - 直接コミュニケーション
  - 迅速な意思決定

推奨設定:
  TEAM_SIZE: "small"
  BRANCH_STRATEGY: "github-flow"
  DEVELOPMENT_STYLE: "agile"
  
自動生成ルール:
  - .cursor/rules/templates/team-structure/small-team.mdc
```

### Medium Team (4-10人)

```yaml
特徴:
  - バランス型プロセス
  - 定期ミーティング
  - 段階的意思決定

推奨設定:
  TEAM_SIZE: "medium"
  BRANCH_STRATEGY: "git-flow"
  DEVELOPMENT_STYLE: "agile"
  
自動生成ルール:
  - .cursor/rules/templates/team-structure/medium-team.mdc
```

### Large Team (10人以上)

```yaml
特徴:
  - 構造化プロセス
  - 正式な承認プロセス
  - リスク管理重視

推奨設定:
  TEAM_SIZE: "large"
  BRANCH_STRATEGY: "git-flow"
  DEVELOPMENT_STYLE: "waterfall"
  
自動生成ルール:
  - .cursor/rules/templates/team-structure/large-team.mdc
```

---

## 📋 セットアップ後チェックリスト

### ✅ 必須確認事項

- [ ] **エントリーポイント存在**: `.cursor/rules/mdc-metadata-manager.mdc`
- [ ] **プロジェクト設定完了**: `.cursor-project-config`ファイル
- [ ] **基本ルールファイル**: core/ディレクトリ内の3ファイル
- [ ] **実装ログシステム**: implementation/logging/内の2ファイル
- [ ] **技術固有ルール**: 使用技術に対応したルール存在
- [ ] **GitHub Actions**: `.github/workflows/cursor-rules-check.yml`

### ✅ 品質確認

```bash
# 構造チェック
./.cursor/rules/scripts/validate-structure.sh

# 期待される結果: エラー0件、警告3件以下
```

### ✅ パフォーマンス確認

```bash
# ファイルサイズチェック
du -sh .cursor/rules/

# 期待される結果: 500KB以下
```

### ✅ セキュリティ確認

```bash
# 機密情報チェック
grep -ri "password\|secret\|token" .cursor/rules/ || echo "セキュリティ問題なし"
```

---

## 🎯 次のステップ

### Phase 1: 基本運用開始（1-2週間）

1. **チームへの共有**
   ```bash
   # README更新・チーム通知
   git add README.md
   git commit -m "docs: update README with Cursor Rules system"
   ```

2. **基本動作確認**
   - Cursorでの開発体験確認
   - ルール適用状況の検証
   - チームフィードバック収集

### Phase 2: カスタマイズ・最適化（3-4週間）

1. **プロジェクト特化ルール追加**
   ```bash
   # 独自ルール作成
   code .cursor/rules/implementation/custom-business-rules.mdc
   ```

2. **パフォーマンス調整**
   ```bash
   # 週次レポート確認
   ./.cursor/rules/scripts/generate-report.sh
   ```

### Phase 3: 高度活用（1-2ヶ月後）

1. **CI/CD統合強化**
   ```yaml
   # GitHub Actions拡張
   - ルール品質の自動チェック
   - 定期レポート生成
   - プルリクエスト品質ゲート
   ```

2. **メトリクス分析**
   ```bash
   # 開発効率測定
   - コード品質向上率
   - 開発速度向上率
   - エラー削減率
   ```

---

## 🔧 トラブルシューティング

### 🚨 よくある問題

#### 問題1: スクリプト実行エラー

```bash
# 症状
bash: ./cursor-rules-setup.sh: Permission denied

# 解決法
chmod +x cursor-rules-setup.sh
./cursor-rules-setup.sh
```

#### 問題2: Cursorでルールが適用されない

```bash
# 症状
Cursorがルールファイルを認識しない

# 解決法1: エントリーポイント確認
cat .cursor/rules/mdc-metadata-manager.mdc | grep "alwaysApply: true"

# 解決法2: Cursor再起動
# Cursorを完全に終了し、プロジェクトを再度開く
```

#### 問題3: GitHub Actions失敗

```bash
# 症状
ワークフローでvalidationエラー

# 解決法: ローカルでチェック実行
./.cursor/rules/scripts/validate-structure.sh

# 修正後再プッシュ
git add .cursor/rules/
git commit -m "fix: resolve validation errors"
git push
```

#### 問題4: パフォーマンス低下

```bash
# 症状
Cursorの動作が重い

# 解決法: alwaysApply設定見直し
grep -r "alwaysApply: true" .cursor/rules/ --include="*.mdc" | wc -l

# 10個以上の場合は不要なものをfalseに変更
```

### 🆘 サポート・ヘルプ

#### セルフヘルプ

```bash
# 1. システム状況確認
./.cursor/rules/scripts/generate-report.sh

# 2. 構造チェック
./.cursor/rules/scripts/validate-structure.sh

# 3. ログ確認
tail -f ~/.cursor/logs/cursor.log
```

#### コミュニティサポート

- **GitHub Issues**: プロジェクトリポジトリのIssues
- **ドキュメント**: `.cursor/rules/`内の各種.mdcファイル
- **例**: 他のプロジェクトでの実装例参照

#### プロフェッショナルサポート

- **プロジェクト管理者**: 技術的相談
- **開発チームリーダー**: 運用方針相談
- **外部コンサルタント**: 大規模導入支援

---

## 📊 成功指標・KPI

### 開発効率指標

| 指標 | 導入前 | 目標値 | 測定方法 |
|------|--------|--------|----------|
| コード品質 | - | +30% | ESLint エラー数削減 |
| 開発速度 | - | +20% | 機能あたり開発時間短縮 |
| バグ発生率 | - | -40% | 本番バグ数削減 |
| レビュー効率 | - | +50% | PR レビュー時間短縮 |

### 導入成功基準

**1週間後**:
- [ ] 全チームメンバーがCursor Rulesを使用
- [ ] 基本ルールが正常に動作
- [ ] 重大な問題が0件

**1ヶ月後**:
- [ ] プロジェクト固有ルールが完成
- [ ] CI/CD統合が稼働
- [ ] 品質指標が+10%以上改善

**3ヶ月後**:
- [ ] 全目標KPIを達成
- [ ] チーム満足度80%以上
- [ ] 他プロジェクトへの横展開検討

---

## 🎉 おめでとうございます！

Cursor Rules Project Starter Kitのセットアップが完了しました。

### 🚀 今すぐできること

1. **Cursorを開いて**: 新しいルールシステムを体験
2. **チームに共有**: 導入効果をチーム全体で享受
3. **フィードバック**: 改善点があれば積極的に提案

### 📈 継続的改善

- **週次**: システム状況レポート確認
- **月次**: ルール見直し・最適化
- **四半期**: KPI測定・改善計画策定

---

**🎯 重要**: このシステムは「導入」ではなく「運用」が成功の鍵です。継続的な改善とチーム全体での活用を心がけてください。

**👥 コミュニティ**: あなたの成功事例が、他のプロジェクトの参考になります。ぜひ経験を共有してください！

---

**📝 クイックスタートガイド完了日**: 2025年7月20日  
**次回更新予定**: 2025年10月20日  
**バージョン**: 1.0.0 