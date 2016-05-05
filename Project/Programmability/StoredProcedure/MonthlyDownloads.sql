ALTER PROCEDURE [dbo].[MonthlyDownloads] AS SELECT
        CAST(
                MONTH(DownloadLog.DownloadDate) AS VARCHAR(2)
        ) + '-' + CAST(
                YEAR(DownloadLog.DownloadDate) AS VARCHAR(4)
        ) AS "Month-Year",
        -- Take the major and minor number and combine into X.XX format
        CAST(
                Version.VersionMajorNumber AS VARCHAR(10)
        ) + '.' + CAST(
                Version.VersionMinorNumber AS VARCHAR(10)
        ) AS 'Version',
        Product.Name AS 'Product',
        COUNT(*) AS 'Total Download Count'
FROM
        DownloadLog
INNER JOIN Download ON DownloadLog.DownloadID = Download.DownloadID
INNER JOIN Release ON Download.ReleaseID = Release.ReleaseID
INNER JOIN Version ON Release.VersionID = Version.VersionID
INNER JOIN Product ON Version.ProductID = Product.ProductID
GROUP BY
        Version.VersionMajorNumber,
        Version.VersionMinorNumber,
        Product.Name,
        CAST(
                MONTH(DownloadLog.DownloadDate) AS VARCHAR(2)
        ) + '-' + CAST(
                YEAR(DownloadLog.DownloadDate) AS VARCHAR(4)
        )
