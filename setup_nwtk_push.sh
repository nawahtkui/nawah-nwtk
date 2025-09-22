#!/bin/bash

# ➤ الانتقال إلى المستودع المركزي
cd ~/nawah-nwtk || exit

echo "📦 بدء تجميع ملفات NWTK في المستودع المركزي..."

# ➤ نسخ العقود الذكية
[ -d ~/nawah-core/contracts ] && cp -r ~/nawah-core/contracts/* ./contracts/ && echo "✅ نسخ العقود"

# ➤ نسخ الاختبارات
[ -d ~/nawah-hardhat/tests ] && cp -r ~/nawah-hardhat/tests/* ./tests/ && echo "✅ نسخ الاختبارات"

# ➤ نسخ الوثائق
[ -d ~/nawah-nwtk/docs ] && cp -r ~/nawah-nwtk/docs/* ./docs/ && echo "✅ نسخ الوثائق"

# ➤ نسخ السكربتات
[ -d ~/my-scripts ] && cp -r ~/my-scripts/* ./scripts/ && echo "✅ نسخ السكربتات"

# ➤ إنشاء الملفات الأساسية إذا لم تكن موجودة
[ ! -f docs/SECURITY.md ] && echo -e "# SECURITY.md\n\n## Ownership & Transparency\n- Project Owner: nawahtkui\n- Last Updated: $(date +%Y-%m-%d)" > docs/SECURITY.md
[ ! -f docs/Tokenomics.md ] && echo -e "# Tokenomics\n\nTotal Supply: 100,000,000 NWTK\n\nDistribution:\n- Team: 10,000,000\n- Ecosystem: 20,000,000\n- Public Sale: 50,000,000\n- Reserves: 20,000,000" > docs/Tokenomics.md

# ➤ إضافة الملفات إلى Git
git add .
git commit -m "Merge all NWTK files into central repository"

# ➤ ربط المستودع بمستودع GitHub عبر SSH
git remote set-url origin git@github.com:nawahtkui/nawah-nwtk.git

# ➤ رفع الملفات إلى GitHub
git push -u origin main

echo "🎉 تم رفع جميع الملفات إلى GitHub بنجاح!"
