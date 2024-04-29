#DATACLEANING
SELECT * FROM layoffs_staging2

SELECT MAX(total_laid_off), MAX(percentage_laid_off) FROM layoffs_staging2;

SELECT * FROM layoffs_staging2
WHERE percentage_laid_off  =1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT industry, SUM(funds_raised_millions)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(funds_raised_millions)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

 SELECT YEAR(`date`), SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY YEAR(`date`)
 ORDER BY 1 DESC;
 
 SELECT stage, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY stage
 ORDER BY 1 DESC;
 
 SELECT company, avg(percentage_laid_off)
 FROM layoffs_staging2
 GROUP BY company 
 ORDER BY 2 DESC;
 
 SELECT substring(`date`, 1, 7) AS `MONTH` , SUM(total_laid_off)
 FROM layoffs_staging2
 WHERE substring(`date`, 1, 7)  IS NOT NULL
  GROUP BY substring(`date`, 1, 7)
  ORDER BY 1 ASC;
  
  WITH Rolling_Total AS
   SELECT substring(`date`, 1, 7) AS `MONTH` , SUM(total_laid_off) AS Total_off
 FROM layoffs_staging2
 WHERE substring(`date`, 1, 7)  IS NOT NULL
  GROUP BY substring(`date`, 1, 7)
  ORDER BY 1 ASC
  )
  SELECT `MONTH`, SUM(Total_off) OVER(ORDER BY `MONTH`)
  FROM Rolling_Total
  
  WITH Rolling_Total AS (
   SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS Total_off
   FROM layoffs_staging2
   WHERE `date` IS NOT NULL
   GROUP BY SUBSTRING(`date`, 1, 7)
   ORDER BY `MONTH` ASC
)
SELECT `MONTH`, SUM(Total_off) OVER (ORDER BY `MONTH`) AS Rolling_Total
FROM Rolling_Total;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY company ASC;

WITH company_Year (company, years, total_laid_off) AS 
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
	SELECT *, DENSE_RANK() OVER(PARTITION BY Years ORDER BY total_laid_off DESC
    FROM Company_Year;
    
    WITH company_Year (company, years, total_laid_off) AS 
(
    SELECT company, YEAR(`date`), SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
)
SELECT company, years, total_laid_off, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC)
FROM company_Year;


  
  
  
  
  