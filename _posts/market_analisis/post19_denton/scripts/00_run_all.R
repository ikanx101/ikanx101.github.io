# =============================================================================
# 00_run_all.R
# Master script: menjalankan seluruh pipeline simulasi Denton dari awal.
# Jalankan dari root project: Rscript scripts/00_run_all.R
# =============================================================================

script_dir <- "scripts"

source(file.path(script_dir, "01_generate_data.R"))
source(file.path(script_dir, "02_denton_disaggregation.R"))
source(file.path(script_dir, "03_visualization.R"))

cat("\n=== Pipeline selesai ===\n")
cat("- Data mentah & hasil     -> output/*.rda\n")
cat("- Visualisasi             -> plots/*.png\n")
