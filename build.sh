#!/bin/sh
# يُشغَّل على Render (أو محلياً): ينتج مجلد dist الجاهز للنشر
set -e
rm -rf dist && mkdir -p dist/lib dist/fonts
cp index.html manifest.webmanifest sw.js icon-192.png icon-512.png icon-maskable-512.png apple-touch-icon.png dist/
CD=https://cdnjs.cloudflare.com/ajax/libs
curl -fsSL $CD/dexie/3.2.4/dexie.min.js -o dist/lib/dexie.min.js
curl -fsSL $CD/pdf.js/3.11.174/pdf.min.js -o dist/lib/pdf.min.js
curl -fsSL $CD/pdf.js/3.11.174/pdf.worker.min.js -o dist/lib/pdf.worker.min.js
curl -fsSL $CD/jspdf/2.5.1/jspdf.umd.min.js -o dist/lib/jspdf.umd.min.js
FN=https://cdn.jsdelivr.net/npm/@fontsource/ibm-plex-sans-arabic@5/files
for w in 400 500 700; do for s in arabic latin; do
  curl -fsSL $FN/ibm-plex-sans-arabic-$s-$w-normal.woff2 -o dist/fonts/plex-$s-$w.woff2 || echo "تحذير: تعذر تنزيل الخط $s-$w"
done; done
# رقم نسخة جديد عند كل نشر ليتحدّث الكاش عند المستخدمين
sed -i "s/__V__/$(date +%s)/" dist/sw.js
echo "تم: dist جاهز"
