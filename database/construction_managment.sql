DROP DATABASE construction_managment;
CREATE DATABASE IF NOT EXISTS construction_managment;

use construction_managment;

-- Table: roles
DROP TABLE IF EXISTS roles;

CREATE TABLE
    roles (
        role_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(50) UNIQUE NOT NULL
    );

-- Table: users
DROP TABLE IF EXISTS users;

CREATE TABLE
    users (
        user_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
        password VARCHAR(50) NOT NULL,
        phone VARCHAR(12) NOT NULL,
        role_id int,
        FOREIGN KEY (role_id) REFERENCES roles (role_id) ON DELETE SET NULL
    );

-- Table: resident
DROP TABLE IF EXISTS residents;

CREATE TABLE
    residents (
        resident_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(70) NOT NULL,
        phone VARCHAR(12) NOT NULL
    );

-- Table: grocers
DROP TABLE IF EXISTS grocers;

CREATE TABLE
    grocers (
        grocer_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(70) NOT NULL,
        phone VARCHAR(12) NOT NULL,
        details VARCHAR(100)
    );
    
    
-- Table: Construction Stages
DROP TABLE IF EXISTS construction_stages;

CREATE TABLE
    construction_stages (
        stage_id INT AUTO_INCREMENT PRIMARY KEY,
        stage_code VARCHAR(5) NOT NULL,
        stage_name VARCHAR(100) NOT NULL,
        unit_price DECIMAL(9, 2) NOT NULL
    );

-- Table: contracts
DROP TABLE IF EXISTS contracts;

CREATE TABLE
    contracts (
        contract_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL, -- nombre de contratista
        rfc VARCHAR(30) NOT NULL, -- RFC de contratista
        address VARCHAR(255) NOT NULL, -- direccion de contrato
        contract_code VARCHAR(100) NOT NULL, -- codigo de contrato
        suburb VARCHAR(100) NOT NULL, -- suburbio, fraccionamiento 
        location VARCHAR(100) NOT NULL, -- coto de fraccionamiento
        resident_id INT, -- Residente de contrato
        grocer_id INT, -- Bodeguero de contrato
        stage_id INT NOT NULL, -- Status de la obra
        total_progress DECIMAL(5, 2) DEFAULT 0 NOT NULL, -- Progreso del proyecto
        created_by INT, -- Creado por el usuario
        FOREIGN KEY (created_by) REFERENCES users (user_id) ON DELETE SET NULL,
        FOREIGN KEY (resident_id) REFERENCES residents (resident_id) ON DELETE SET NULL,
        FOREIGN KEY (grocer_id) REFERENCES grocers (grocer_id) ON DELETE SET NULL,
        FOREIGN KEY (stage_id) REFERENCES construction_stages(stage_id)
    );
    


-- Table: Suppliers  Proveedores
DROP TABLE IF EXISTS suppliers;

CREATE TABLE
    suppliers (
        supplier_id INT AUTO_INCREMENT PRIMARY KEY,
        trade_name VARCHAR(100) NOT NULL, -- Nombre comercial
        company_name VARCHAR(255) NOT NULL, -- Razon social o empresa
        rfc VARCHAR(30) NOT NULL, -- RFC de proveedor
        name_contact VARCHAR(70) NOT NULL, -- Nombre de proveedor
        phone_contact VARCHAR(70) NOT NULL, -- Telefono de proveedor
        email_contact VARCHAR(100) UNIQUE, -- Correo de proveedor
        address VARCHAR(150) NOT NULL, -- Direccion de proveedor
        product VARCHAR(30) -- Tipo de producto que provee
    );

-- Table: Units measures
DROP TABLE IF EXISTS measures;

CREATE TABLE
    measures (
        measure_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(10) UNIQUE NOT NULL,
        details VARCHAR(20) NOT NULL
    );

-- Table: Material Categories
DROP TABLE IF EXISTS material_categories;

CREATE TABLE
    material_categories (
        category_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(10) UNIQUE NOT NULL
    );

-- Table: Inventories INVENTARIO
DROP TABLE IF EXISTS inventories;

CREATE TABLE
    inventories (
        inventory_id INT AUTO_INCREMENT PRIMARY KEY,
        material_code VARCHAR(10) NOT NULL UNIQUE, -- Codigo de producto o material
        name VARCHAR(50) NOT NULL, -- Nombre de producto o material
        details VARCHAR(255) NOT NULL, -- Descripcion del material
        category_id INT NOT NULL, -- Categoria de material
        measure_id INT NOT NULL, -- Unidad de medida
        stock DECIMAL(10, 2) NOT NULL default 0, -- Cantidad existente
        grocer_id INT,
        last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (measure_id) REFERENCES measures (measure_id) ON DELETE CASCADE,
        FOREIGN KEY (grocer_id) REFERENCES grocers(grocer_id)  ON DELETE CASCADE,
        FOREIGN KEY (category_id) REFERENCES material_categories (category_id) ON DELETE CASCADE
    );

-- Table: Material Requisitions REQUERIMIENTOS
DROP TABLE IF EXISTS material_requisitions;

CREATE TABLE
    material_requisitions (
        requisition_id INT AUTO_INCREMENT PRIMARY KEY,
        order_number VARCHAR(10) NOT NULL, -- Numero de Orden
        contract_id INT NOT NULL, -- Numero de contrato
        supplier_id INT, -- Proveedor
        requested_by INT, -- Requerido por el usuario
        grocer_id INT, -- Bodeguero que recibe
        request_date DATE NOT NULL, -- Fecha de pedido
        delivery_date DATE NOT NULL, -- Fecha de entrega
        delivery_location VARCHAR(100) NOT NULL, -- Lugar de entrega
        received_by VARCHAR(100) NOT NULL, -- Recibe no es un usuario
        status_material ENUM ('PENDING', 'APPROVED', 'DELIVERED', 'CANCELED') DEFAULT 'PENDING',
        notes varchar(150),
        FOREIGN KEY (contract_id) REFERENCES contracts (contract_id) ON DELETE CASCADE,
        FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id) ON DELETE SET NULL,
        FOREIGN KEY (grocer_id) REFERENCES grocers (grocer_id) ON DELETE SET NULL,
        FOREIGN KEY (requested_by) REFERENCES users (user_id) ON DELETE SET NULL
    );

-- Table: Requisitions Details
DROP TABLE IF EXISTS requisitions_details;

CREATE TABLE
    requisitions_details (
        detail_id INT AUTO_INCREMENT PRIMARY KEY,
        requisition_id INT,
        material_code INT,
        created_at TIMESTAMP,
        quantity DECIMAL(10, 2) NOT NULL,
        unit_price DECIMAL(10, 2) NOT NULL,
        subtotal DECIMAL(15, 2) NOT NULL,
        iva DECIMAL(10, 2) NOT NULL,
        discount DECIMAL(15, 2) DEFAULT 0,
        total_amount DECIMAL(15, 2),
        notes varchar(30),
        FOREIGN KEY (requisition_id) REFERENCES material_requisitions (requisition_id) ON DELETE CASCADE,
        FOREIGN KEY (material_code) REFERENCES inventories(inventory_id) ON DELETE RESTRICT,
        FOREIGN KEY (measure_id) REFERENCES measures (measure_id) ON DELETE SET NULL
    );
    

        
-- Table: Housing Units (Caratula Datos Total de casas)
DROP TABLE IF EXISTS housing_units;

CREATE TABLE
	housing_units(
		housing_id INT AUTO_INCREMENT PRIMARY KEY,
        contract_id INT,
        quantity INT NOT NULL,
        FOREIGN KEY (contract_id) REFERENCES contracts(contract_id)
    );
    


-- Table: Budgets CONCENTRADOS
DROP TABLE IF EXISTS invoices;

CREATE TABLE invoices (
        invoice_id INT AUTO_INCREMENT PRIMARY KEY,
        invoice_number Varchar(50) NOT NULL,
        order_date DATE NOt NULL,
        contract_id INT NOT NULL,
        supplier_id INT NOT NULL,
        requisition_id INT,
        invoice_type ENUM("Requerimiento de material", "Anticipo de proyecto") DEFAULT "Requerimiento de material",
        amount DECIMAL(10, 2) NOT NULL,
		invoice_date DATE NOT NULL,
        invoice_payment_date DATE NOT NULL,
        payment_type ENUM('Contado', 'Credito') default 'Contado',
        FOREIGN KEY (contract_id) REFERENCES contracts (contract_id) ON DELETE CASCADE,
		FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id) ON DELETE CASCADE,
		FOREIGN KEY (requisition_id) REFERENCES material_requisitions(requisition_id) ON DELETE CASCADE);


    	-- Table: Budget Advances (Anticipos)
DROP TABLE IF EXISTS budget_advances;
    
CREATE TABLE 
	budget_advances(
		budget_advance_id INT AUTO_INCREMENT PRIMARY KEY,
        invoice_id INT NOT NULL, 
        advance_date DATE,
        percentage DECIMAL(5, 2) DEFAULT 0,
        FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id) ON DELETE CASCADE
    );
    
    
    -- Table: Extraordinary Concepts  (Caratula Datos Extraordinarios)
DROP TABLE IF EXISTS extraordinary_concepts;

CREATE TABLE
	extraordinary_concepts(
		extraordinary_id INT AUTO_INCREMENT PRIMARY KEY,
        contract_id INT NOT NULL,
        estimate_id INT NOT NULL,
        description_concept VARCHAR(70),
        quantity INT NOT NULL,
        unit_price DECIMAL(10, 2) NOT NULL,
        total_amount DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (estimate_id) REFERENCES project_estimates (estimate_id) ON DELETE CASCADE,
        FOREIGN KEY (contract_id) REFERENCES contracts(contract_id)
    );
    
    
	-- Table: Guarantee Funds (Fondos de garantia)
DROP TABLE IF EXISTS guarantee_funds;
    
CREATE TABLE 
	guarantee_funds(
		guarantee_fund_id INT AUTO_INCREMENT PRIMARY KEY,
        guarantee_fund_date DATE,
        percentage DECIMAL(4, 2) NOT NULL,
        amount DECIMAL(10, 2) NOT NULL
    );
    


    
    -- Table: Project Invoice Summary (Caratula Datos Resumen general)
DROP TABLE IF EXISTS project_invoice_summary;

CREATE TABLE
	project_invoice_summary(
		summary_id INT AUTO_INCREMENT PRIMARY KEY,
        contract_id INT,
        total_amount DECIMAL(15, 2) NOT NULL,
		budget_advance_id INT NOT NULL,
        outstanding_balance_advance DECIMAL(15, 2), -- Saldo a ejercer de anticipo
        guarantee_fund_id INT,	
        outstanding_balance_fund DECIMAL(15, 2),  -- Saldo a ejercer de fondo de garantia
        withholding_material_id INT, -- Retencion de inventario
        material_discount DECIMAL(12, 2), -- Descuentos de materiales
        billable_balance DECIMAL(10, 2) NOT NULL, -- Saldo Facturable
        last_update TIMESTAMP,
        FOREIGN KEY (contract_id) REFERENCES contracts(contract_id),
        FOREIGN KEY (budget_advance_id) REFERENCES budget_advances(budget_advance_id) ON DELETE CASCADE,
        FOREIGN KEY (guarantee_fund_id) REFERENCES guarantee_funds(guarantee_fund_id),
        FOREIGN KEY (withholding_material_id) REFERENCES material_requisitions(requisition_id)
    );
    

-- Table: Project Estimates (Estimacion de proyecto)
DROP TABLE IF EXISTS project_estimates;

CREATE TABLE
    project_estimate (
        estimate_id INT AUTO_INCREMENT PRIMARY KEY,
        estimate_number INT NOT NULL,
        contract_id INT NOT NULL,
        estimate_date DATE NOT NULL,
        housing_id INT NOT NULL,
        total_amount DECIMAL(15, 2) NOT NULL,
        fg_retention DECIMAL(15, 2) NOT NULL,
        advance_retention DECIMAL(15, 2) NOT NULL,
        material_retention DECIMAL(15, 2) NOT NULL,
        total_to_pay DECIMAL(15, 2) NOT NULL,
        description VARCHAR(255) NOT NULL,
        unit VARCHAR(50) NOT NULL,
        FOREIGN KEY (housing_id) REFERENCES housing_units(housing_id) ON DELETE CASCADE,
		FOREIGN KEY (contract_id) REFERENCES contracts (contract_id) ON DELETE CASCADE
    );
    
		-- Table: Estimate Details
DROP TABLE IF EXISTS estimate_details;

CREATE TABLE
	estimate_detail(
		estimate_detail_id INT AUTO_INCREMENT PRIMARY KEY,
        estimate_id INT NOT NULL,
        contract_id INT NOT NULL,
        housing_id INT NOT NULL,
        FOREIGN KEY (estimate_id) REFERENCES project_estimates (estimate_id) ON DELETE CASCADE,
        FOREIGN KEY (contract_id) REFERENCES contracts(contract_id) ON DELETE CASCADE,
        FOREIGN KEY (housing_id) REFERENCES housing_units(housing_id) ON DELETE SET NULL
    );
    
    
	-- Table: Conctract Stages (por si los contratos tienen diferentes etapas de construccion)
DROP TABLE IF EXISTS stage_progress;

CREATE TABLE
	stage_progress(
		progress_id INT AUTO_INCREMENT PRIMARY KEY,
        estimate_id INT NOT NULL, -- Estimacion
        unit_price DECIMAL(10, 2) NOT NULL, -- Precio por unidad
        stage_id INT NOT NULL, -- Etapa de construccion
        housing_id 	INT NOT NULL, -- Cantidad de casas
        previous_estimate_volume INT NOT NULL, -- Estimacion anterior
        current_estimate_volume INT NOT NULL, -- Esta estimacion
        accumulated_volume INT NOT NULL, -- Acumulado hasta la fecha
        remaining_estimate INT NOT NULL DEFAULT 0, -- Casas restantes
        current_amount DECIMAL(10, 2) NOT NULL, -- Importe de estimacion
        discount DECIMAL(8, 2), -- Descuentos
        
        FOREIGN KEY (estimate_id) REFERENCES project_estimates(estimate_id) ON DELETE CASCADE,
		FOREIGN KEY (stage_id) REFERENCES construction_stages(stage_id) ON DELETE CASCADE,
		FOREIGN KEY (housing_id) REFERENCES housing_units(unit_id) ON DELETE CASCADE
    );
    
    	-- Table: Conctract Stages (por si los contratos tienen diferentes etapas de construccion)
DROP TABLE IF EXISTS stage_progress;

CREATE TABLE
	stage_progress(
    stage_progress_id INT AUTO_INCREMENT PRIMARY KEY,
    estimate_id INT NOT NULL,
    extraordinary_id INT NOT NULL,
    
    
);
    
    

-- Table: Work Progress
DROP TABLE IF EXISTS work_progress;

CREATE TABLE
    work_progress (
        progress_id INT AUTO_INCREMENT PRIMARY KEY,
        stage_id INT NOT NULL,
        progress_date DATE NOT NULL,
        estimate_number INT NOT NULL,
        executed_quantity DECIMAL(10, 2) NOT NULL,
        progress_percentage DECIMAL(5, 2) NOT NULL,
        updated_by INT,
        FOREIGN KEY (updated_by) REFERENCES users (user_id) ON DELETE SET NULL,
        FOREIGN KEY (stage_id) REFERENCES construction_stages (stage_id) ON DELETE CASCADE
    );

DELIMITER //
CREATE TRIGGER update_inventory_on_delivery AFTER
UPDATE ON material_requisitions FOR EACH ROW BEGIN IF (NEW.status = 'DELIVERED') THEN
INSERT INTO
    inventories (material_code, name, details, measure_id, stock)
SELECT
    rd.material_code,
    rd.name,
    rd.details,
    rd.measure_id,
    rd.quantity
FROM
    requisitions_details rd
WHERE
    rd.requisition_id = NEW.requisition_id ON DUPLICATE KEY
UPDATE stock = stock + rd.quantity;

END IF;

END // 
