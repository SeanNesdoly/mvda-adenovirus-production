README: metadata file for archiving research data

Adapted from the Federated Research Data Repository (FRDR):
  https://www.frdr-dfdr.ca/docs/txt/README.txt

Internal versioning of template README:
  Git tag: readme-v0.3.1 (2024-01-23) (revision: 50360dc)
  Source: https://github.com/SeanNesdoly/DigitalTwin/blob/master/docs/README.txt

Viral Vectors and Vaccines Bioprocessing Group
http://amine-kamen.lab.mcgill.ca
Department of Bioengineering
McGill University, Montreal QC

--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
GENERAL INFORMATION
--------------------------------------------------------------------------------
This README.txt file was completed on 2024-01-23 by
  Sean Nesdoly
  <sean.nesdoly@mail.mcgill.ca>
  Research Assistant
  Viral Vectors and Vaccines Bioprocessing Group
  Department of Bioengineering
  McGill University, Montréal QC

PROJECT
  Digital-twin of bioreactor for accelerated design and optimal operations in
  production of complex biologics - Mechanistic models to describe biological
  processes more realistically.

PUBLICATION
  TITLE
    Multivariate data analysis on multi-sensor measurement for in-line process
    monitoring of adenovirus production in HEK293 cells

  JOURNAL DATA
    NAME     Biotechnology and Bioengineering (under revision)
    YEAR     2024
#   VOLUME   [#]
#   ISSUE    [#]
#   PAGES    [start-end]
#   ACCEPTED [yyyy-mm-dd or n/a]
#   REVISED  [yyyy-mm-dd or n/a]
#   RECEIVED [yyyy-mm-dd or n/a]
#   DOI      [unique identifier]
#   PMID     [unique identifier]
#   ISSN     [unique identifier]
#   eISSN    [unique identifier]

DATA TYPES
  Discrete time series bioproccess data produced by multiple sensors during and
  after bioreactor productions operated in batch and fed-batch modes. Depending
  on the variable, measurements are taken off-, at-, on-, and in-line.

AUTHORS
  PRIMARY
    Xingge Xu <xingge.xu@mail.mcgill.ca>

  README (this file)
    Sean Nesdoly <sean.nesdoly@mail.mcgill.ca>

  CORRESPONDENCE
    Amine A. Kamen <amine.kamen@mcgill.ca>
    Department of Bioengineering
    McGill University
    McConnell Engineering Building, Room 363
    3480 University Street
    Montreal QC, Canada H3A 0E9

  ALL AUTHORS (SORTED)
    Xingge Xu
    Omar Farnós
    Barbara C.M.F. Paes
    Sean Nesdoly
    Amine A. Kamen

DATA REPOSITORY INFORMATION
  Borealis, the Canadian Dataverse Repository
    https://borealisdata.ca
    https://borealisdata.ca/dataverse/Kamen_Lab
    https://www.mcgill.ca/library/services/data-services/sharing/dataverse
      <rdm.library@mcgill.ca>

  Initial date of submission to repository: 2024-01-23

--------------------------------------------------------------------------------
METHODOLOGICAL INFORMATION
--------------------------------------------------------------------------------

1. Description of methods used for generation of data:

     BIOPROCESS DATA
       Lucullus®, a Process Information Management System (PIMS; Securecell AG,
       In der Luberzen 29, 8902 Urdorf, Switzerland), was used to acquire and
       store all data.  Most process data produced in real-time by sensors
       attached to the bioreactor were measured by way of a 'my-Control' control
       unit (Applikon Biotechnology, Delft, the Netherlands; Getinge).

       Importantly, each device/sensor communicates with Lucullus at different
       intervals; as such, Lucullus provides three methods for logging data that
       can be set by the operator for each variable. Logging intervals are
       usually set to a multiple of the device's communication interval. Logging
       methods include:

         ACTIVE
           A set period of time is specified by the user to sample the signal.

         PASSIVE
           Logging of data occurs based on communication interval of the device.

         CHANGES ONLY
           The signal is only logged when changed; a deadband can be set such
           that a change is only logged if it exceeds a defined deviation. Here,
           the signal is recored at least once every 15 minutes.

       Logging parameters for the important variables (Lucullus 'ports') in each
       bioreactor run are captured in the corresponding Excel spreadsheet's
       'Explain' sheet.

     DIELECTRIC PROBE
       A dielectric probe (ABER FUTURA, Aberystwyth, UK) was used to acquire
       capacitance and conductivity measurements.

     MULTI-WAVELENGTH FLUOROMETER
       An in-situ probe connected to a spectrometer was used for in-line
       monitoring of culture fluorescence under excitation of two LED light
       sources at 365 nm (λ_ex=365 nm) and 410 nm (λ_ex=410 nm) (Karakach et
       al., 2019). The spectrometer captured emission spectra from 300 to 1000
       nm from each excitation light every 5 minutes.

       Special thanks to Dr. Boris Tartakovsky (National Research Council of
       Canada, Montreal QC) for the loan and implementation of this equipment.

     For more specific details of data generation methods with reference to
     experimental setup, please see the associated publication.

2. Methods used to process the data, if any:

     Raw bioprocess data stored in Lucullus was exported and processed further
     in MATLAB® R2022a (The MathWorks, Inc., Natick, Massachusetts, United
     States). Code used for processing of data is openly available on GitHub at
     the following link:

       Private repository prior to publication:
         https://github.com/SeanNesdoly/mvda-adenovirus-production

       Public repository, to be made available after publication:
         https://github.com/xxgatgithub/mvda-adenovirus-production

3. Instrument- or software-specific information needed to interpret the data:

     LUCULLUS PROCESS INFORMATION MANAGEMENT SYSTEM
       Version 3.8.5, schema version 3.8.41

     APPLIKON MY-CONTROL UNIT
       Device software: V1_11
       Hardware version: 1.0 subversion 3
       FPGA version: 1.0 subversion 16
       Microcontroller version: 1.0 subversion 10

     DIELECTRIC PROBE
       Futura Supervisory Control and Data Acquisition (SCADA) software system
       Version 2.2.0, October 2020

       Probe and system information via FuturaTool 3.0.4.0:
         Device Type: Standard Futura
         Part Number: 233000
         Bootloader Version: 234207p10
         Firmware Version: 233007122
         Time & Date of Manufacture: 09:06 26 Mar 2015

         Hardware Mode: Futura Connect Mode

         Current Loop Settings:
                   Capacitance   Conductivity
           4mA         0 pF/cm        0 mS/cm
           20mA      200 pF/cm       40 mS/cm
           Offset      0 pF/cm        0 mS/cm
           Gain        1              1

         Currents Lower Than 4mA: Enabled
         Currents Higher Than 20mA: Enabled

         Modbus Settings:
           Baudrate 38400
           Parity Even
           Address 6

         Biomass Factor: 1E+06 CPM per pF/cm

         Measurement Mode: Custom
         Measuring Frequency: 600 kHz
         Pol C: BM220 PolC
         Filter: 5
         Capacitance Zero Value: 0 pF/cm

       @TODO(sean): Document differences between raw and processed capacitance
       measurements, with reference to their variable names.

     MULTI-WAVELENGTH FLUOROMETRY SYSTEM 5.0
       Requests to access software can be made to the corresponding author.

       Internal version information for MWF system as implemented at the Viral
       Vectors and Vaccines Bioprocessing Group:

         https://github.com/SeanNesdoly/DigitalTwin (private repo)
           Git commit: 485121f
           Author: Sean Nesdoly <srnesdoly@gmail.com>
           Date:   2022-06-30T20:03:02-04:00

       @TODO(sean): Provide MWF *.ini configuration files with variable values!
       This would only be truly useful if given access to the MWF sourcecode;
       however, we do not currently have permission to openly it.

     OFF-LINE MEASUREMENTS
       Devices/sensors used to capture off-line measurements (requiring manual
       entry of data into Lucullus):

         * Vi-Cell XR cell counter (Beckman Coulter, Brea CA, USA)
             - Viable Cell Density  (VCD)
             - Total Cell Densities (TCD)
             - Cell Viabilities     (VIA)

         * Bioprofile® FLEX2 metabolite analyzer (NOVA Biomedical, Waltham MA, USA)

     MATLAB® R2022a
       @TODO(sean): Give specific library versions?

4. Standards and calibration information, if applicable:

     # Lot numbers, calibration methods

     Please refer to the 'Materials and Methods' section of the publication.

       @TODO(sean): Summarize details from publication? Limit duplication.
       Examples: calibration methods for DO, pH, biomass

5. Experimental conditions:

     HOST SYSTEM
       HEK293SF-3F6 cells (National Research Council Canada, Montreal QC,
       Canada)

     VIRUS
       Adenovirus containing the Fusion protein from Newcastle Disease Virus
       (Farnós et al., 2020). The 'Cell Growth' batch was not subjected to
       infection.

     CELL CULTURE MEDIUM
       * Initial growth and passaging:
         - HyClone Hycell TransFx-H medium
         - 6 mM of L-glutamine (Cytiva Life Sciences, Chicago IL, USA)
         - 0.1% Kolliphor poloxamer 188 (MilliporeSigma, Oakville ON, Canada)

       * Supplementary medium feed:
         - HyClone Cell Boost 5 supplement (Cytiva Life Sciences, Chicago IL, USA)
         - L-glutamine

     For more details, please refer to the 'Materials and Methods' section of
     the publication. Specifically, see Table 1.

6. All people involved, with descriptions of their roles:

     @TODO(sean): Complete after final publication

     Xingge Xu

     Dr. Omar Farnós

     Barbara C.M.F. Paes

     Sean Nesdoly

     Prof. Amine A. Kamen

     Dr. Boris Tartakovsky
       National Research Council of Canada, Montreal QC

--------------------------------------------------------------------------------
SUMMARY OF DATASET
@TODO(sean): Remove whitespace from all filenames (reflect update in code, too)
@TODO(sean): Standardize order of variables (columns)!
@TODO(sean): Convert all Excel sheets to a non-proprietary format (CSV)
@TODO(sean): Fix Excel column spacing for easy viewing of data
--------------------------------------------------------------------------------

Archiving & compression methods applied to dataset:

  $ tar cvzf mvda_adenovirus_bioprocess_data.tar.gz ./

Hash of archived dataset to confirm integrity:

  $ sha256sum mvda_adenovirus_bioprocess_data.tar.gz > \
    mvda_adenovirus_bioprocess_data.tar.gz.sha256
  $ cat mvda_adenovirus_bioprocess_data.tar.gz.sha256
  888bf5af54c513ce87f479fded09c2ac05e9595d55f7a9494d228491c3e23089 mvda_adenovirus_bioprocess_data.tar.gz

To validate SHA256 checksum against archived dataset:

  $ sha256sum --check mvda_adenovirus_bioprocess_data.tar.gz.sha256

LIST OF FILES

  Four bioreactors were operated in batch or fed-batch modes (refer to Table 1
  in publication for more details):

    1) Cell Growth  (CG)
    2) Adenovirus 1 (AdV01)
    3) Adenovirus 2 (AdV02)
    4) Adenovirus 3 (AdV03)
  
  Each bioreactor run contains the following files (X is the name of the batch):

    ├── X_LucullusBioprocessData.xlsx
    └── X_MWF/
        ├── *.time
        └── spectra/
            └── *.dat

  Explanation:
    * An Excel spreadsheet of bioprocess data, each containing three sheets,
      named like '*_LucullusBioprocessData.xlsx'. Sheet contents:

        - Sheet 1, 'Lucullus Data':
            Bioprocess data exported from Lucullus, including dielectric data
        - Sheet 2, 'Capacitance':
            Dielectric data acquired via Futura SCADA
        - Sheet 3, 'Explain' (excluding batch CG):
            Lucullus variable (port) specifications

    * An '*_MWF/spectra/' directory. This contains the emission spectra data
      produced by the multi-wavelength fluorometer.

  NOTE: The file/directory naming scheme given in the tree of files below
  corresponds to the bioreactor batch names defined above.

  ```
  $ \tree -nF

  ./
  ├── README.txt
  ├── mvda_adenovirus_bioprocess_data.tar.gz.sha256
  └── mvda_adenovirus_bioprocess_data.tar.gz/      # (contents after extracting)
      ├── AdV01_LucullusBioprocessData.xlsx
      ├── AdV01_MWF/
      │   ├── Br02-AD-F hycell.time
      │   ├── Spec_Area1.txt
      │   ├── changes.txt
      │   ├── predict_var.txt
      │   └── spectra/
      │       ├── Br02-AD-F hycell00000.dat
      │       ├── ...
      │       └── Br02-AD-F hycell01733.dat
      ├── AdV02_LucullusBioprocessData.xlsx
      ├── AdV02_MWF/
      │   ├── Barbara BR2.time
      │   ├── Spec_Area1.txt
      │   ├── background.txt
      │   ├── changes.txt
      │   ├── predict_var.txt
      │   └── spectra/
      │       ├── Barbara BR200000.dat
      │       ├── ...
      │       └── Barbara BR201732.dat
      ├── AdV03_LucullusBioprocessData.xlsx
      ├── AdV03_MWF/
      │   ├── BR03.time
      │   ├── Spec_Area1.txt
      │   ├── background-OFF.txt
      │   ├── background-oN.txt
      │   ├── changes.txt
      │   ├── predict_var.txt
      │   └── spectra/
      │       ├── BR0300000.dat
      │       ├── ...
      │       └── BR0301226.dat
      ├── CellGrowth_LucullusBioprocessData.xlsx
      └── CellGrowth_MWF/
          ├── Spec_Area1.txt
          ├── predict_var.txt
          ├── spectra/
          │   ├── xxaav0300000.dat
          │   ├── ...
          │   └── xxaav0302013.dat
          └── xxaav03.time
  
  10 directories, 6731 files
  ```
  Generated: 2024-01-22T13:10:09

DISK USAGE STATISTICS

  ```
    $ du -h ./*.xlsx ./*_MWF/spectra/

    26M     ./AdV01_LucullusBioprocessData.xlsx
    28M     ./AdV02_LucullusBioprocessData.xlsx
    20M     ./AdV03_LucullusBioprocessData.xlsx
    37M     ./CellGrowth_LucullusBioprocessData.xlsx
    343M    ./AdV01_MWF/spectra/
    346M    ./AdV02_MWF/spectra/
    244M    ./AdV03_MWF/spectra/
    402M    ./CellGrowth_MWF/spectra/
  ```
  Generated: 2024-01-22T13:42:11

RELATIONSHIPS BETWEEN FILETYPES

  For each bioreactor batch X, X_LucullusBioprocessData.xlsx contains all
  bioprocess data, except for the corresponding emission spectra data generated
  by the multi-wavelength fluorometer, which is contained in the directory
  'X_MWF/spectra/' as plain text *.dat files.

ADDITIONAL DATA COLLECTED BUT NOT INCLUDED

  N/A

--------------------------------------------------------------------------------
FILE-SPECIFIC INFORMATION
--------------------------------------------------------------------------------

CellGrowth_LucullusBioprocessData.xlsx

  Instrument used    : Lucullus PIMS via Applikon my-Control unit
  Excel worksheet    : Sheet 1 (Lucullus Data)
  Date of generation : 2022-09-02T13:19:17 to 2022-09-09T11:43:33
  Metadata in file?  : Yes
  Dimensions         : 119607 rows, 74 columns

  Instrument used    : Aber Futura in-situ probe via Futura SCADA
  Excel worksheet    : Sheet 2 (Capacitance)
  Date of generation : 2022-09-02T12:05 to 2022-09-09T11:58
  Metadata in file?  : Yes (no units)
  Dimensions         : 20147 rows, 16 columns

AdV01_LucullusBioprocessData.xlsx

  Instrument used    : Lucullus PIMS via Applikon my-Control unit
  Excel worksheet    : Sheet 1 (Lucullus Data)
  Date of generation : 2022-05-14T11:42:33 to 2022-05-20T10:23:42
  Metadata in file?  : Yes
  Dimensions         : 102565 rows, 64 columns

  Instrument used    : Aber Futura in-situ probe via Futura SCADA
  Excel worksheet    : Sheet 2 (Capacitance)
  Date of generation : 2022-05-14T11:28 to 2022-05-20T10:25
  Metadata in file?  : Yes (no units)
  Dimensions         : 8578 rows, 22 columns

AdV02_LucullusBioprocessData.xlsx

  Instrument used    : Lucullus PIMS via Applikon my-Control unit
  Excel worksheet    : Sheet 1 (Lucullus Data)
  Date of generation : 2022-06-17T14:09:33 to 2022-06-23T10:33:05
  Metadata in file?  : Yes
  Dimensions         : 100914 rows, 68 columns

  Instrument used    : Aber Futura in-situ probe via Futura SCADA
  Excel worksheet    : Sheet 2 (Capacitance)
  Date of generation : 2022-06-17T14:09 to 2022-06-23T14:16
  Metadata in file?  : Yes (no units)
  Dimensions         : 8646 rows, 22 columns

AdV03_LucullusBioprocessData.xlsx
@TODO: Biomass column is broken!

  Instrument used    : Lucullus PIMS via Applikon my-Control unit
  Excel worksheet    : Sheet 1 (Lucullus Data)
  Date of generation : 2022-07-07T13:55:28 to 2022-07-11T12:47:26
  Metadata in file?  : Yes
  Dimensions         : 68191 rows, 71 columns

  Instrument used    : Aber Futura in-situ probe via Futura SCADA
  Excel worksheet    : Sheet 2 (Capacitance)
  Date of generation : 2022-07-07T12:43 to 2022-07-11T18:28
  Metadata in file?  : Yes (no units)
  Dimensions         : 6104 rows, 22 columns

*_LucullusBioprocessData.xlsx

  Common variables (columns) across all bioprocess data exported from Lucullus
  ('Lucullus Data' sheet):

    Time                Fractional hours since start of bioprocess
    Timestamp           Time with format 'dd-mm-yyy hh:mm:ss' (Eastern timezone)
    m_do                Measurement Dissolved Oxygen (DO) (%)
    m_ph                Measurement pH
    m_stirrer           Measurement stirrer speed (rpm)
    m_temp              Measurement temperature sensor (Celsius)
    sp_do               Setpoint for DO
    sp_ph               Setpoint for pH
    sp_stirrer          Setpoint for stirrer
    sp_temp             Setpoint for temperature
    cs_do               Control status for DO loop (1 when under control)
    cs_ph               Control status for pH loop (1 when under control)
    cs_stirrer          Control status for stirrer loop (1 when under control)
    cs_temp             Control status for temperature loop (1 when under conrol)
    dm_air              Dose monitor Air MFC (Mass Flow Controller; cumulative)
    dm_co2              Dose monitor CO2 MFC
    dm_o2               Dose monitor O2 MFC
    dm_spump1           Dose monitor stepper pump 1 (base)
    m_air               Value of Air MFC (mL/min)
    m_co2               Value of CO2 MFC (mL/min)
    m_o2                Value of O2 MFC (mL/min)
    sp_air              Setpoint for Air MFC (mL/min)
    sp_co2              Setpoint for CO2 MFC (mL/min)
    sp_o2               Setpoint for O2 MFC (mL/min)
    sp_spump1_perc      Setpoint for Stepper pump 1 (%)
    sp_co2_perc         Setpoint for CO2 MFC (%)
    sp_o2_perc          Setpoint for O2 MFC (%)
    m_o2_perc           Value of O2 MFC (%)
    pid_do_ct           DO Cycle time
    pid_do_d            DO D
    pid_do_i            DO I
    pid_do_judge        DO judge
    pid_do_p            DO P
    pid_ph_ct           pH Cycle time
    pid_ph_d            pH D
    pid_ph_dz           pH Dead Zone
    pid_ph_i            pH I
    pid_ph_judge        pH judge
    pid_ph_p            pH P
    pid_temp_ct         Temperature Cycle time
    pid_temp_d          Temperature D
    pid_temp_i          Temperature I
    pid_temp_judge      Temperature judge
    pid_temp_p          Temperature P
    co_temp             Control Output temperature loop (%)
    co_do               Control Output DO loop (%)
    co_stirrer          Control Output Stirrer (%)
    co_ph               Control Output pH loop (%)
    A_FEED              1 for time of feed
    A_INN               1 for time of inoculation
    A_SAMPLE            1 for time of sampling
    A_Trans             1 for time of transfection/infection
    A_volume            Volume change of the Action (mL)
    F_Glun_Add          Total amount of glutamine feed (mmol)
    F_Glun_Con          Concentration of glutamine feed (mmol/L)
    F_Glun_Vol          Volume of glutamine feed (mL)
    F_sup_Vol           Supplementary medium added (mL)
    M_AMM               Ammonia   concentration from metabolite analyzer (mmol/L)
    M_CAL               Calcium   concentration from metabolite analyzer
    M_GLUC              Glucose   concentration from metabolite analyzer (g/L)
    M_GLUN              Glutamine concentration from metabolite analyzer (mmol/L)
    M_GLUT              Glutamate concentration from metabolite analyzer (mmol/L)
    M_LAC               Lactate   concentration from metabolite analyzer (g/L)
    M_POT               Potassium concentration from metabolite analyzer
    M_SOD               Sodium    concentration from metabolite analyzer
    M_TDENS             Total cell density by cell counter (Million cells/mL)
    M_VDENS             Viable cell density by cell counter (Million cells/mL)
    M_VIAB              Cell viability by cell counter (%)
    VT_TCID             Virus titre by TCID50 (Million cells/mL)
    M_VDENS_MICROSCOPE  Viable cell density by microscope
    M_VIAB_MICROSCOPE   Cell viability by microscope

    Unique to CellGrowth dataset:
      ADD COLUMNS:
        f_capacitance
        f_conductivity
        m_air_perc (%)
        m_co2_perc (%)
        sp_air_perc (%)

      REMOVE COLUMNS:
        F_sup_Vol (no supplementary medium feed was given)
        VT_TCID   (given that infection did not occur)

  Common variables (columns) across all capacitance data exported from the
  dielectric probe via Futura SCADA ('Capacitance' sheet):

    Time Stamp
    Run_Time
    Biomass
    Capacitance (pF/cm)
    Conductivity (mS/cm)
    Zero Time Stamp
    Messages
    Dual Frequency
    Polarisation Correction
    Measuring Frequency (KHz)
    High Frequency (KHz)
    Raw_Measure_Capacitance
    Raw High Capacitance (pF/cm)
    Raw Pol Low Capacitance (pF/cm)
    Raw Pol High Capacitance (pF/cm)
    Raw_Conductivity
    Filter Value
    Zeroed Capacitance (pF/cm)
    Pol Correction Capacitance (pF/cm)
    Auto Clean
    Hours Between Auto Cleans
    Clean Recovery Time (Mins)

    @TODO(sean): Note changes in column order & variable names due to migration
    from FuturaLite to FuturaSCADA exports, then to direct use of Lucullus for
    acquiring capacitance data.

CellGrowth_MWF/

  Instrument used    : Multi-Wavelength Fluorometry System 5.0
  Date of generation : 2022-09-02T12:10:53 to 2022-09-09T11:56:09
  Metadata in file?  : Yes (no units)
  Number of spectra  : 2014

AdV01_MWF/

  Instrument used    : Multi-Wavelength Fluorometry System 5.0
  Date of generation : 2022-05-14T10:35:53 to 2022-05-20T11:01:05
  Metadata in file?  : Yes (no units)
  Number of spectra  : 1734

AdV02_MWF/

  Instrument used    : Multi-Wavelength Fluorometry System 5.0
  Date of generation : 2022-06-17T14:08:31 to 2022-07-07T11:50:46
  Metadata in file?  : Yes (no units)
  Number of spectra  : 1733

AdV03_MWF/

  Instrument used    : Multi-Wavelength Fluorometry System 5.0
  Date of generation : 2022-07-07T12:42:24 to 2022-07-14T15:54:12
  Metadata in file?  : Yes (no units)
  Number of spectra  : 1227

*.dat

  An in-situ probe shines light on material contained within a bioreactor vessel
  and captures the light that is reflected using a spectrometer. This plain text
  file contains one emission spectra captured by excitation from two LED light
  sources (365 and 410 nm) averaged across multiple scans that are taken over a
  specified integration time. The fluorescense intensity values given have been
  subtracted by their corresponding background intensity that was captured at
  the same wavelength without incident exitation light. Example file header
  until first line of data:

    ```
    Process_Name: xxaav03
    Date: 02/09/2022
    Time: 12:10:53
    Process_Time(days): 0.0001723
    Light_Status(1=on): 1 1 
    Light_Name: uv 365 uv 400
    Light_Control_Type(0=Phidget,1=COMport,2=LPT1,3=LabJack,4=LabJack(reversed),5=Phidget(reversed)): 0 0
    Voltage(V): 4.5 3.5
    Integration_Time(ms): 200.0 200.0
    Scans_To_Average: 10 10
    Boxcar_Width(px): 20
    Acquisition_Interval(min): 5.0
    --------------------------------------------------
    180.96483 24.575624999999945 -36.65864062499941
    ```

  Line format:

    wavelength l1 l2

  where:

    wavelength is in nanometres (nm)
    l1 = light1_fluorescence_intensity - light1_background_intensity
    l2 = light2_fluorescence_intensity - light2_background_intensity

background*.txt

  Background spectra are acquired by turning both lights off and performing a
  scan. This is done for each light to account for any differences in:

    - spectra scan integration time
    - number of scans used when averaging

  For each wavelength captured by the spectrometer, the background fluorescense
  intensity is given for lights one and two. Line format:

    wavelength light1_background_intensity light2_background_intensity

*.time

  Contains the date (dd/mm/yyy), time (hh:mm:ss), and filepath for each
  emission spectra (*.dat) obtained during the entire operation of the
  bioprocess. Example file header until first line of data:

    ```
    Process_Name: xxaav03
    Integration_Time(ms): 200.0 200.0
    Scans_To_Average: 10 10
    Acquisition_Interval(min): 5.0
    --------------------------------------------------
    Date     Time     File Name
    02/09/2022 12:10:53 C:\Users\Amine\Desktop\MWF_export\xxaav03\xxaav0300000.dat
    ```

Spec_Area1.txt

  Six intervals are defined as A1 through A6; each interval is defined by
  user-specified start and end wavelengths. For each interval, the area under
  the curve for the current emission spectra is calculated by integration. This
  file contains the area under the emission spectra's curve for each interval A1
  through A6, for each emission spectra scan. Example file header until first
  line of data:

    ```
    Process_Name: xxaav03
    Area_Name: A1 A2 A3 A4 A5 A6
    Area_Light_#: 1 1 1 2 2 2
    Area_Start_Wavelength(nm): 700.0 670.0 715.0 400.0 400.0 0.0
    Area_End_Wavelength(nm): 750.0 730.0 740.0 450.0 450.0 0.0
    02/09/2022 12:10:53 0.0001724 0.0 -0.11422003221011688 -0.11408672301668005 24.599604248433266 3.2876979318836916 0.0
    ```

  Line format:

    dd/mm/yyy hh:mm:ss T A1 A2 A3 A4 A5 A6

  where:

    T is fractional days since the process started
    Ax is the area under the emission spectra's curve for interval Ax

predict_var.txt

  NOTE: this file was not used in this study; details are only given for
  completeness.

  Given an interval defined by user-specified start and end wavelengths, the
  area under the current emission spectra's curve is calculated. After AUCs A1
  through A6 are obtained, an AUC prediction is made for the next emission
  spectra based on the current and previously acquired spectras using a
  customizable regression equation (model) that uses up to two AUCs.
    
    @TODO(sean): Define available real-time regression models (runPrediction())

  Model prediction equations configured in the MWF system for each bioreactor
  batch were defined as:

    m1 = k1 * A1    where k1=1.0
    m2 = k2 * A2    where k2=1.0

  Line format:

    dd/mm/yyy hh:mm:ss T m1 m2 m3 m4 m5

  where:

    T is fractional days since the process started
    mx denotes the predicted AUC for the next spectra using model x

changes.txt

  Log of changes made to the settings of the multi-wavelength fluorometry
  system by an operator. Line format:
    
    dd/mm/yyyy hh:mm:ss variable:old_value->new_value

  Variable changes done at the same time are separated by whitespace on the same
  line.

--------------------------------------------------------------------------------
SUPPLEMENTARY INFORMATION
# @TODO: Include any unstructured information that is of relevance.
--------------------------------------------------------------------------------

# EXAMPLES
#   Describe the relationship(s) that this dataset has with ancillary datasets
#   already submitted to a repository (provide full citation/DOI/URL).
#
#     Similarly, if the selected data repository supports versioning for editing
#     submitted data, list the publications that cite or use this data (provide
#     full citation/DOI/URL).
#
#   Is the dataset, or a subset of it, deposited at a domain-specific database,
#   too? If so, provide a citation/DOI/URL for cross-referencing.
#
#   Was the dataset derived from another source? If so, provide the appropriate
#   details and/or contact information.
#
#   List any licenses or restrictions placed on the data, especially if done in
#   collaboration with an industrial partner.
#
#   If the dataset is in a stable state, has it been deposited to Canada's
#   Federated Research Data Repository (or something like it)?
#     https://www.frdr-dfdr.ca/repo/
