SELECT DISTINCT c.channel_name AS Channel, COUNT(*) AS Engagement FROM users u JOIN channels c ON u.channel_id=c.channel_id GROUP BY c.channel_id;



SELECT 
    c.channel_name AS Channel, 
    COUNT(*) AS Total_Users,
    SUM(CASE WHEN s.segment_name = 'conversion rates' THEN 1 ELSE 0 END) AS Conversions
    
FROM users u
JOIN channels c ON u.channel_id = c.channel_id
JOIN segments s ON u.segment_id = s.segment_id
GROUP BY c.channel_id, c.channel_name;




SELECT 
    'Open Rate' AS Segment_Category,
    SUM(CASE WHEN c.channel_name = 'Email' THEN 1 ELSE 0 END) AS Email_Users,
    SUM(CASE WHEN c.channel_name = 'SMS' THEN 1 ELSE 0 END) AS SMS_Users,
    SUM(CASE WHEN c.channel_name = 'WhatsApp' THEN 1 ELSE 0 END) AS WhatsApp_Users
FROM users u
JOIN segments s ON u.segment_id = s.segment_id
JOIN channels c ON u.channel_id = c.channel_id
WHERE s.segment_name = 'open rate'

UNION

SELECT 
    'Click Rates' AS Segment_Category,
    SUM(CASE WHEN c.channel_name = 'Email' THEN 1 ELSE 0 END) AS Email_Users,
    SUM(CASE WHEN c.channel_name = 'SMS' THEN 1 ELSE 0 END) AS SMS_Users,
    SUM(CASE WHEN c.channel_name = 'WhatsApp' THEN 1 ELSE 0 END) AS WhatsApp_Users
FROM users u
JOIN segments s ON u.segment_id = s.segment_id
JOIN channels c ON u.channel_id = c.channel_id
WHERE s.segment_name = 'click rates'

UNION

SELECT 
    'Conversion Rates' AS Segment_Category,
    SUM(CASE WHEN c.channel_name = 'Email' THEN 1 ELSE 0 END) AS Email_Users,
    SUM(CASE WHEN c.channel_name = 'SMS' THEN 1 ELSE 0 END) AS SMS_Users,
    SUM(CASE WHEN c.channel_name = 'WhatsApp' THEN 1 ELSE 0 END) AS WhatsApp_Users
FROM users u
JOIN segments s ON u.segment_id = s.segment_id
JOIN channels c ON u.channel_id = c.channel_id
WHERE s.segment_name = 'conversion rates'

ORDER BY Segment_Category;






